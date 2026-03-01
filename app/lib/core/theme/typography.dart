import 'package:flutter/material.dart';
import 'colors.dart';

class ItqanTypography {
  ItqanTypography._();

  static const String arabicFont = 'NotoNaskhArabic';

  static const TextStyle arabicLarge = TextStyle(
    fontFamily: arabicFont,
    fontSize: 32,
    height: 2.2,
    color: ItqanColors.snow,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle arabicMedium = TextStyle(
    fontFamily: arabicFont,
    fontSize: 24,
    height: 2.0,
    color: ItqanColors.snow,
  );

  static const TextStyle arabicSmall = TextStyle(
    fontFamily: arabicFont,
    fontSize: 18,
    height: 1.8,
    color: ItqanColors.silver,
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: ItqanColors.snow,
    letterSpacing: -0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: ItqanColors.snow,
    letterSpacing: -0.3,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ItqanColors.silver,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ItqanColors.mist,
  );

  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ItqanColors.cloud,
    letterSpacing: 0.2,
  );

  static const TextStyle gold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ItqanColors.gold,
    letterSpacing: 0.2,
  );
}
