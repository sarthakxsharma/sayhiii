import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/message_model.dart';
import 'history_controller.dart';

class MessageController extends ChangeNotifier {
  MessageModel _message = MessageModel();
  bool _isLoading = false;

  MessageModel get message => _message;
  bool get isLoading => _isLoading;

  void updatePhoneNumber(String completeNumber) {
    _message.phoneNumber = completeNumber;
    notifyListeners();
  }

  void updateMessage(String text) {
    _message.message = text;
    notifyListeners();
  }

  /// Formats phone number by extracting only digits
  String _formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// Builds WhatsApp URL with phone number and message
  String _buildWhatsAppUrl(String phoneNumber, String message) {
    final formattedNumber = _formatPhoneNumber(phoneNumber);
    final encodedMessage = Uri.encodeComponent(message);
    
    // WhatsApp URL format: https://wa.me/{phoneNumber}?text={message}
    return 'https://wa.me/$formattedNumber${message.isNotEmpty ? '?text=$encodedMessage' : ''}';
  }

  /// Opens WhatsApp with the phone number and message
  Future<bool> _launchWhatsApp(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('Cannot launch WhatsApp URL: $url');
        return false;
      }
    } catch (e) {
      debugPrint('Error launching WhatsApp: $e');
      return false;
    }
  }

  Future<void> sendMessage(HistoryController? historyController) async {
    if (!_message.isValid) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Save to history if valid
      if (historyController != null) {
        await historyController.addToHistory(_message.phoneNumber);
      }

      // Build WhatsApp URL
      final whatsappUrl = _buildWhatsAppUrl(
        _message.phoneNumber,
        _message.message,
      );

      debugPrint('Opening WhatsApp with URL: $whatsappUrl');

      // Launch WhatsApp
      final launched = await _launchWhatsApp(whatsappUrl);

      if (!launched) {
        debugPrint('Failed to launch WhatsApp');
      }
    } catch (e) {
      debugPrint('Error in sendMessage: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _message = MessageModel();
    _isLoading = false;
    notifyListeners();
  }
}

