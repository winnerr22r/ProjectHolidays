import 'package:flutter/material.dart';

/// Color palette for the app
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF4A90E2); // Soft blue
  static const Color primaryLight = Color(0xFF7CB9F7); // Light blue
  static const Color primaryDark = Color(0xFF2E5C9E); // Dark blue

  // Accent colors
  static const Color accent = Color(0xFFFF9800); // Orange
  static const Color accentLight = Color(0xFFFFB74D); // Light orange

  // Neutral colors
  static const Color background = Color(0xFFFAFBFC); // Off-white
  static const Color surface = Color(0xFFFFFFFF); // Pure white
  static const Color surfaceVariant = Color(0xFFF5F7FA); // Light gray

  // Text colors
  static const Color textPrimary = Color(0xFF1A1A1A); // Almost black
  static const Color textSecondary = Color(0xFF757575); // Gray
  static const Color textTertiary = Color(0xFFBDBDBD); // Light gray

  // Border and divider
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);

  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF4A90E2),
    Color(0xFF357ABD),
  ];

  static const List<Color> accentGradient = [
    Color(0xFFFF9800),
    Color(0xFFE68900),
  ];

  static const List<Color> splashGradient = [
    Color(0xFF667EEA),
    Color(0xFF764BA2),
  ];
}

/// Spacing constants
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

/// Border radius constants
class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
}

/// Elevation/Shadow constants
class AppElevation {
  static const double sm = 2.0;
  static const double md = 4.0;
  static const double lg = 8.0;
  static const double xl = 12.0;
}

/// Duration constants
class AppDuration {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);
}
