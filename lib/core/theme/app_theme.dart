import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Simple theme provider to be used while building the app.
class AppTheme {
  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        surface: AppColors.background,
        primary: AppColors.primary,
        secondary: AppColors.accent,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData dark() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ),
    );
  }
}
