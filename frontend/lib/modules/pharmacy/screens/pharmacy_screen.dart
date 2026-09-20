import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../widgets/order_medicines_card.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('JeevanCare Pharmacy', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const OrderMedicinesCard(),
          const SizedBox(height: 16),
          _buildFeatureTile(
            icon: Icons.flash_on_rounded,
            title: 'Express 2-Hour Delivery',
            subtitle: 'Guaranteed delivery from local certified pharmacies',
            color: AppColors.primary,
          ),
          const SizedBox(height: 10),
          _buildFeatureTile(
            icon: Icons.verified_user_rounded,
            title: '100% Genuine Medicines',
            subtitle: 'Directly sourced from verified pharma manufacturers',
            color: AppColors.secondary,
          ),
          const SizedBox(height: 10),
          _buildFeatureTile(
            icon: Icons.percent_rounded,
            title: 'Up to 25% Off Every Order',
            subtitle: 'Best price guarantee on generics and branded drugs',
            color: AppColors.ratingGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimensions.rounded12,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.subtitle),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
