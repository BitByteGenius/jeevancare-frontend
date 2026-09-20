import 'package:flutter/material.dart';

class ServiceTabModel {
  final String id;
  final String label;
  final IconData icon;
  final int iconColorHex;
  final int iconBgColorHex;

  const ServiceTabModel({
    required this.id,
    required this.label,
    required this.icon,
    this.iconColorHex = 0xFFFF5B4D,
    this.iconBgColorHex = 0xFFFFECE9,
  });
}
