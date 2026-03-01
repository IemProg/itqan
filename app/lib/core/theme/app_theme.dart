import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ItqanColors.void_,
      colorScheme: const ColorScheme.dark(
        primary: ItqanColors.gold,
        secondary: ItqanColors.goldLight,
        surface: ItqanColors.onyx,
        error: ItqanColors.error,
        onPrimary: ItqanColors.void_,
        onSecondary: ItqanColors.void_,
        onSurface: ItqanColors.snow,
        onError: ItqanColors.void_,
      ),
      cardTheme: CardThemeData(
        color: ItqanColors.onyx,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ItqanRadius.lg),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ItqanColors.void_,
        foregroundColor: ItqanColors.snow,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ItqanColors.obsidian,
        selectedItemColor: ItqanColors.gold,
        unselectedItemColor: ItqanColors.mist,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ItqanColors.charcoal,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ItqanRadius.md),
          borderSide: BorderSide.none,
        ),
      ),
      dividerColor: ItqanColors.charcoal,
      iconTheme: const IconThemeData(color: ItqanColors.silver),
    );
  }
}
