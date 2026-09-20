import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';

class LabTestsScreen extends StatelessWidget {
  const LabTestsScreen({super.key});

  final List<Map<String, dynamic>> tests = const [
    {
      'title': 'Comprehensive Full Body Checkup',
      'tests': 'Includes 84 vital tests (CBC, Lipid, Liver, Kidney, Thyroid & Sugar)',
      'price': 999,
      'mrp': 2499,
      'discount': 60,
      'tag': 'MOST POPULAR',
    },
    {
      'title': 'Complete Blood Count (CBC) Profile',
      'tests': 'Hemoglobin, RBC, WBC, Platelets count & differential indices',
      'price': 299,
      'mrp': 499,
      'discount': 40,
      'tag': 'ESSENTIAL',
    },
    {
      'title': 'Thyroid Function Test (T3, T4, TSH)',
      'tests': 'Comprehensive evaluation of thyroid gland hormonal activity',
      'price': 349,
      'mrp': 600,
      'discount': 42,
      'tag': 'WELLNESS',
    },
    {
      'title': 'Diabetes Screening (HbA1c & Fasting Sugar)',
      'tests': '3-month average blood glucose analysis and instantaneous glucose',
      'price': 449,
      'mrp': 800,
      'discount': 44,
      'tag': 'DIABETES CARE',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Lab Tests & Health Packages', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Home sample collection banner
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              borderRadius: AppDimensions.rounded12,
              border: Border.all(color: AppColors.secondaryDark.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.home_work_rounded, color: AppColors.secondaryDark, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '100% Safe Home Sample Collection',
                        style: AppTypography.subtitle.copyWith(color: AppColors.secondaryDark, fontSize: 13.5),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Certified phlebotomists • Digital reports in 12-24 hours',
                        style: AppTypography.caption.copyWith(color: AppColors.secondaryDark),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Text('Popular Health Packages', style: AppTypography.sectionTitle),
          const SizedBox(height: 12),

          ...tests.map((t) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppDimensions.rounded12,
                border: Border.all(color: AppColors.borderLight),
                boxShadow: AppDimensions.subtleShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.badgeOrangeBg,
                          borderRadius: AppDimensions.rounded4,
                        ),
                        child: Text(
                          t['tag'] as String,
                          style: const TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.badgeOrange,
                          ),
                        ),
                      ),
                      Text(
                        '${t['discount']}% off',
                        style: AppTypography.discountText,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(t['title'] as String, style: AppTypography.subtitle.copyWith(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(t['tests'] as String, style: AppTypography.caption),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('₹${t['price']}', style: AppTypography.priceBold.copyWith(fontSize: 16)),
                          const SizedBox(width: 8),
                          Text('₹${t['mrp']}', style: AppTypography.priceStrikethrough),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: AppDimensions.roundedFull),
                        ),
                        child: const Text('Book Test', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
