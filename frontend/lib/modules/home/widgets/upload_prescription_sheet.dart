import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';

class UploadPrescriptionSheet extends StatelessWidget {
  const UploadPrescriptionSheet({super.key});

  static void show(BuildContext context) {
    Get.bottomSheet(
      const UploadPrescriptionSheet(),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upload Prescription',
                    style: AppTypography.headline2.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Our certified pharmacist will verify & dispense your medicines',
                    style: AppTypography.caption,
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close_rounded),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Upload Options
          Row(
            children: [
              Expanded(
                child: _buildUploadOption(
                  icon: Icons.camera_alt_rounded,
                  title: 'Camera',
                  subtitle: 'Take a photo',
                  onTap: () {
                    Get.back();
                    _showSuccessMessage('Camera opened (simulated)');
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildUploadOption(
                  icon: Icons.photo_library_rounded,
                  title: 'Gallery',
                  subtitle: 'Pick from photos',
                  onTap: () {
                    Get.back();
                    _showSuccessMessage('Gallery opened (simulated)');
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildUploadOption(
                  icon: Icons.history_edu_rounded,
                  title: 'Saved',
                  subtitle: 'Past scripts',
                  onTap: () {
                    Get.back();
                    _showSuccessMessage('Loading saved prescriptions');
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Prescription Guidelines Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.tickerBg,
              borderRadius: AppDimensions.rounded12,
              border: Border.all(color: AppColors.tickerBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.verified_rounded, size: 18, color: AppColors.tickerIcon),
                    const SizedBox(width: 8),
                    Text(
                      'Valid Prescription Guidelines',
                      style: AppTypography.subtitle.copyWith(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildGuidelineItem('Doctor Details & Reg. Number clearly visible'),
                _buildGuidelineItem('Patient Name & Date of Consultation'),
                _buildGuidelineItem('Medicine names, dosage, and duration'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Guarantee badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_rounded, size: 16, color: AppColors.ratingGreen),
              const SizedBox(width: 6),
              Text(
                '100% Genuine Medicines • Delivered in 2 Hours',
                style: AppTypography.caption.copyWith(
                  color: AppColors.ratingGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppDimensions.rounded12,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppDimensions.rounded12,
          border: Border.all(color: AppColors.borderMedium),
          boxShadow: AppDimensions.subtleShadow,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTypography.subtitle.copyWith(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: AppTypography.caption.copyWith(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: AppColors.tickerIcon, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: AppTypography.caption.copyWith(color: AppColors.textSecondary, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(String message) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryDark,
      duration: const Duration(seconds: 2),
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
    );
  }
}
