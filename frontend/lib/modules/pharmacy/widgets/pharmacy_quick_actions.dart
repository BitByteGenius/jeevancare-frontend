import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../controllers/pharmacy_controller.dart';

class PharmacyQuickActions extends StatelessWidget {
  const PharmacyQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PharmacyController.to;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          // Order with prescription
          Expanded(
            child: InkWell(
              onTap: () => Get.toNamed(AppRoutes.uploadPrescription),
              borderRadius: AppDimensions.rounded12,
              child: Container(
                height: 96,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FB), // Light soft blue
                  borderRadius: AppDimensions.rounded12,
                  border: Border.all(color: const Color(0xFFDCE6F5)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Order with\nprescription',
                        style: AppTypography.subtitle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    _buildRxIllustration(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Call to order medicines
          Expanded(
            child: InkWell(
              onTap: () => controller.showCallOrderSheet(context),
              borderRadius: AppDimensions.rounded12,
              child: Container(
                height: 96,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF6F0), // Light soft mint green
                  borderRadius: AppDimensions.rounded12,
                  border: Border.all(color: const Color(0xFFD1EBDD)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Call to order\nmedicines',
                        style: AppTypography.subtitle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    _buildCallIllustration(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRxIllustration() {
    return SizedBox(
      width: 48,
      height: 52,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Clipboard
          Positioned(
            left: 2,
            top: 2,
            child: Container(
              width: 32,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Container(
                    width: 14,
                    height: 5,
                    margin: const EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D4ED8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const Spacer(),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 4, bottom: 4),
                      child: Text(
                        '℞',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Medicine Bottle overlay
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 22,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Column(
                children: [
                  Container(
                    height: 4,
                    width: 14,
                    color: const Color(0xFF60A5FA),
                  ),
                  const Spacer(),
                  const Center(
                    child: Icon(Icons.add, size: 14, color: Colors.white),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallIllustration() {
    return SizedBox(
      width: 48,
      height: 52,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Green medicine bottle
          Positioned(
            right: 2,
            top: 6,
            child: Container(
              width: 30,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 18,
                    color: const Color(0xFF047857),
                  ),
                  const Spacer(),
                  const Center(
                    child: Icon(Icons.add, size: 18, color: Colors.white),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          // Phone handset wrapped around
          Positioned(
            left: 0,
            bottom: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFF047857),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone_rounded,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
