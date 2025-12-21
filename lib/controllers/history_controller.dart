import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/history_model.dart';

class HistoryController extends ChangeNotifier {
  List<HistoryModel> _history = [];
  List<HistoryModel>? _cachedUniqueHistory;
  static const String _historyKey = 'phone_history';

  List<HistoryModel> get history {
    // Return cached unique history if available
    if (_cachedUniqueHistory != null) {
      return List.unmodifiable(_cachedUniqueHistory!);
    }
    
    // Remove duplicates based on phone number digits
    final seen = <String>{};
    final uniqueHistory = <HistoryModel>[];
    
    for (final item in _history) {
      final digits = item.phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
      if (!seen.contains(digits)) {
        seen.add(digits);
        uniqueHistory.add(item);
      }
    }
    
    _cachedUniqueHistory = uniqueHistory;
    return List.unmodifiable(uniqueHistory);
  }

  HistoryController() {
    // Load history asynchronously without blocking
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_historyKey);
      
      if (historyJson != null) {
        final List<dynamic> decoded = json.decode(historyJson);
        _history = decoded
            .map((item) => HistoryModel.fromJson(item as Map<String, dynamic>))
            .toList();
        // Sort by timestamp, most recent first
        _history.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        _cachedUniqueHistory = null; // Clear cache
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading history: $e');
    }
  }

  Future<void> _saveHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = json.encode(
        _history.map((item) => item.toJson()).toList(),
      );
      await prefs.setString(_historyKey, historyJson);
    } catch (e) {
      debugPrint('Error saving history: $e');
    }
  }

  Future<void> addToHistory(String phoneNumber) async {
    // Store the complete number with country code (extract only digits for storage)
    final formattedNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (formattedNumber.isEmpty || formattedNumber.length < 10) return;

    // Remove duplicate if exists (compare by digits only)
    _history.removeWhere((item) {
      final itemDigits = item.phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
      return itemDigits == formattedNumber;
    });

    // Add to beginning - store with + prefix for display
    // Reconstruct with + prefix (assume country code based on length)
    String displayNumber;
    if (formattedNumber.startsWith('1') && formattedNumber.length == 11) {
      displayNumber = '+1${formattedNumber.substring(1)}';
    } else if (formattedNumber.startsWith('91') && formattedNumber.length >= 12) {
      displayNumber = '+91${formattedNumber.substring(2)}';
    } else if (formattedNumber.length >= 10) {
      // Default: assume India (+91) for 10-digit numbers
      displayNumber = '+91$formattedNumber';
    } else {
      displayNumber = '+$formattedNumber';
    }

    _history.insert(0, HistoryModel(
      phoneNumber: displayNumber,
      timestamp: DateTime.now(),
    ));

    // Keep only last 50 items
    if (_history.length > 50) {
      _history = _history.take(50).toList();
    }

    _cachedUniqueHistory = null; // Clear cache
    notifyListeners();
    await _saveHistory();
  }

  Future<void> deleteHistoryItem(String phoneNumber) async {
    // Compare by digits only to handle different formats
    final phoneDigits = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    _history.removeWhere((item) {
      final itemDigits = item.phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
      return itemDigits == phoneDigits;
    });
    _cachedUniqueHistory = null; // Clear cache
    notifyListeners();
    await _saveHistory();
  }

  Future<void> clearHistory() async {
    _history.clear();
    _cachedUniqueHistory = null; // Clear cache
    notifyListeners();
    await _saveHistory();
  }
}

