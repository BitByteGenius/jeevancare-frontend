import 'package:flutter/material.dart';

class AppDimensions {
  // Spacing
  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space6 = 6.0;
  static const double space8 = 8.0;
  static const double space10 = 10.0;
  static const double space12 = 12.0;
  static const double space14 = 14.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;

  // Border Radii
  static const double radius4 = 4.0;
  static const double radius6 = 6.0;
  static const double radius8 = 8.0;
  static const double radius10 = 10.0;
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius20 = 20.0;
  static const double radiusFull = 999.0;

  static BorderRadius get rounded4 => BorderRadius.circular(radius4);
  static BorderRadius get rounded6 => BorderRadius.circular(radius6);
  static BorderRadius get rounded8 => BorderRadius.circular(radius8);
  static BorderRadius get rounded12 => BorderRadius.circular(radius12);
  static BorderRadius get rounded16 => BorderRadius.circular(radius16);
  static BorderRadius get rounded20 => BorderRadius.circular(radius20);
  static BorderRadius get roundedFull => BorderRadius.circular(radiusFull);

  // Card & Elevation Shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get subtleShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 6,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];
}
