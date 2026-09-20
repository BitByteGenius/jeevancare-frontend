import 'package:flutter/material.dart';

class QuickActionModel {
  final String id;
  final String title;
  final IconData icon;
  final int iconColorHex;
  final int bgColorHex;
  final String? badgeText;

  const QuickActionModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.iconColorHex,
    required this.bgColorHex,
    this.badgeText,
  });
}
