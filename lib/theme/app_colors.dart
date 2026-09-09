import 'package:flutter/material.dart';

/// App color palette optimized for low-literacy users.
/// Green = money/positive, Red = danger/warning, Blue = info, Orange = pending
class AppColors {
  AppColors._();

  // Primary - Trust & Reliability
  static const Color primary = Color(0xFF2E7D32);       // Green 800
  static const Color primaryLight = Color(0xFF4CAF50);   // Green 500
  static const Color primaryDark = Color(0xFF1B5E20);    // Green 900

  // Secondary - Action & Energy
  static const Color secondary = Color(0xFFFF6F00);      // Amber 900
  static const Color secondaryLight = Color(0xFFFFB300);  // Amber 600

  // Semantic Colors
  static const Color money = Color(0xFF2E7D32);          // Green - earnings, positive
  static const Color danger = Color(0xFFD32F2F);          // Red - hazard, warning
  static const Color info = Color(0xFF1565C0);            // Blue - information
  static const Color pending = Color(0xFFFF6F00);         // Orange - pending/waiting
  static const Color success = Color(0xFF388E3C);         // Green - confirmed/done

  // Material Category Colors
  static const Color pcbColor = Color(0xFF2E7D32);       // Green
  static const Color crtColor = Color(0xFF5D4037);        // Brown
  static const Color lcdColor = Color(0xFF1565C0);        // Blue
  static const Color cableColor = Color(0xFFE65100);      // Deep Orange
  static const Color batteryColor = Color(0xFFD32F2F);    // Red
  static const Color motorColor = Color(0xFF37474F);      // Blue Grey
  static const Color plasticColor = Color(0xFF7B1FA2);    // Purple

  // Backgrounds
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnDanger = Color(0xFFFFFFFF);

  // Status
  static const Color offlineBanner = Color(0xFFFF8F00);
  static const Color onlineBanner = Color(0xFF388E3C);
}
