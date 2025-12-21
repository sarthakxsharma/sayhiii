import 'package:flutter/material.dart';

class AppColors {
  // Main color - Teal
  static const Color primaryTeal = Color(0xFF00897B);
  static const Color tealLight = Color(0xFF4DB6AC);
  static const Color tealDark = Color(0xFF00695C);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightOnBackground = Color(0xFF000000);
  static const Color lightOnSurface = Color(0xFF212121);
  static const Color lightPrimary = primaryTeal;
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightSecondary = Color(0xFF26A69A);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightError = Color(0xFFB00020);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color lightOutline = Color(0xFFE0E0E0);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF000000); // Pure black
  static const Color darkSurface = Color(0xFF000000); // Pure black
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkPrimary = tealLight;
  static const Color darkOnPrimary = Color(0xFF000000);
  static const Color darkSecondary = Color(0xFF4DB6AC);
  static const Color darkOnSecondary = Color(0xFF000000);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkOnError = Color(0xFF000000);
  static const Color darkOutline = Color(0xFF424242);

  // Gradient Colors
  static const Color lightGradientStart = Color(0xFFE0F2F1);
  static const Color lightGradientEnd = Color(0xFFFFFFFF); // Pure white
  static const Color darkGradientStart = Color(0xFF000000); // Pure black
  static const Color darkGradientEnd = Color(0xFF000000); // Pure black

  // Additional Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
}
