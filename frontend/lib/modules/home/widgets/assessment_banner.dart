import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';

class AssessmentBanner extends StatelessWidget {
  const AssessmentBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F5),
        borderRadius: AppDimensions.rounded16,
        border: Border.all(color: const Color(0xFFFFD1DC)),
        boxShadow: AppDimensions.subtleShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Not sure what your gut is telling you?',
                  style: AppTypography.subtitle.copyWith(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFBE123C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Take a quick self-assessment to understand your gut health better',
                  style: AppTypography.caption.copyWith(
                    fontSize: 11.5,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppDimensions.roundedFull,
                      ),
                    ),
                    child: const Text(
                      'Know more',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFFFD1DC)),
            ),
            child: const Icon(
              Icons.healing_rounded,
              color: Color(0xFFE11D48),
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}
