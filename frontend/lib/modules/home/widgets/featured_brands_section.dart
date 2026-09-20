import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';

class FeaturedBrandsSection extends StatelessWidget {
  const FeaturedBrandsSection({super.key});

  final List<Map<String, dynamic>> brands = const [
    {'name': 'Cetaphil', 'color': 0xFF0284C7, 'tag': 'Skincare'},
    {'name': 'Durex', 'color': 0xFF2563EB, 'tag': 'Wellness'},
    {'name': 'Prohance', 'color': 0xFF059669, 'tag': 'Nutrition'},
    {'name': 'Centrum', 'color': 0xFFD97706, 'tag': 'Vitamins'},
    {'name': 'Dabur', 'color': 0xFFDC2626, 'tag': 'Ayurveda'},
    {'name': 'Horlicks', 'color': 0xFFEA580C, 'tag': 'Health Drink'},
    {'name': 'GoodCare', 'color': 0xFF16A34A, 'tag': 'Herbal'},
    {'name': 'Tejasya', 'color': 0xFFCA8A04, 'tag': 'Ayurveda'},
    {'name': 'JeevanCare', 'color': 0xFFFF5B4D, 'tag': 'Essentials'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured brands',
            style: AppTypography.sectionTitle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),

          // 3x3 Circle Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final brand = brands[index];
              return InkWell(
                onTap: () {},
                borderRadius: AppDimensions.roundedFull,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.borderLight, width: 1.5),
                    boxShadow: AppDimensions.cardShadow,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          brand['name'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Color(brand['color'] as int),
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          brand['tag'] as String,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // See All Outlined Pill Button
          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE2E8F0)),
                shape: RoundedRectangleBorder(
                  borderRadius: AppDimensions.rounded8,
                ),
              ),
              child: const Text(
                'See all',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
