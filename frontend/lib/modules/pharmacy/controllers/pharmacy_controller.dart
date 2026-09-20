import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../data/pharmacy_data.dart';

class PharmacyController extends GetxController {
  static PharmacyController get to => Get.find<PharmacyController>();

  final RxInt searchHintIndex = 0.obs;
  final RxInt currentHeroBannerIndex = 0.obs;
  final RxInt currentPetArrivalsIndex = 0.obs;
  final RxInt currentSurveyIndex = 0.obs;
  final RxInt currentStoriesIndex = 0.obs;

  Timer? _searchHintTimer;

  @override
  void onInit() {
    super.onInit();
    _startSearchHintTimer();
  }

  @override
  void onClose() {
    _searchHintTimer?.cancel();
    super.onClose();
  }

  void _startSearchHintTimer() {
    _searchHintTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (PharmacyData.searchHints.isNotEmpty) {
        searchHintIndex.value =
            (searchHintIndex.value + 1) % PharmacyData.searchHints.length;
      }
    });
  }

  void showPrescriptionUploadSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.upload_file_rounded, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Upload Prescription', style: AppTypography.headline2.copyWith(fontSize: 16)),
                        const SizedBox(height: 2),
                        Text('Get medicines delivered in 2 hours', style: AppTypography.caption),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: AppDimensions.rounded12,
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user_rounded, color: AppColors.ratingGreen, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Our pharmacist will review your prescription and confirm your order promptly.',
                      style: AppTypography.caption.copyWith(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildUploadOption(
                    icon: Icons.camera_alt_rounded,
                    title: 'Take Photo',
                    subtitle: 'Use camera',
                    onTap: () {
                      Get.back();
                      Get.snackbar(
                        'Prescription Received',
                        'Camera photo attached. Pharmacist reviewing order.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.textPrimary,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildUploadOption(
                    icon: Icons.photo_library_rounded,
                    title: 'From Gallery',
                    subtitle: 'JPEG, PNG, PDF',
                    onTap: () {
                      Get.back();
                      Get.snackbar(
                        'Prescription Uploaded',
                        'Document uploaded successfully. Processing order.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.textPrimary,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void showCallOrderSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F7F0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.phone_in_talk_rounded, color: Color(0xFF16A34A)),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Call to Order Medicines', style: AppTypography.headline2.copyWith(fontSize: 16)),
                        const SizedBox(height: 2),
                        Text('Toll-Free 8:00 AM - 10:00 PM', style: AppTypography.caption),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: AppDimensions.rounded12,
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1800-266-4357 (JEEVAN-CARE)',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF15803D),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Speak directly with a certified JeevanCare health advisor to dictate your order.',
                    style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'Dialing JeevanCare Helpline',
                    'Connecting you to pharmacist at 1800-266-4357...',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF15803D),
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  shape: RoundedRectangleBorder(borderRadius: AppDimensions.rounded8),
                ),
                icon: const Icon(Icons.call_rounded, color: Colors.white),
                label: const Text('Call Now', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void showCategoriesSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: AppColors.borderMedium,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('All Categories', style: AppTypography.headline2.copyWith(fontSize: 17)),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: PharmacyData.popularCategories.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final cat = PharmacyData.popularCategories[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      cat.title.replaceAll('\n', ' '),
                      style: AppTypography.subtitle.copyWith(fontSize: 13.5),
                    ),
                    trailing: cat.badgeText != null
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEA580C),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              cat.badgeText!,
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textTertiary),
                    onTap: () {
                      Get.back();
                      Get.snackbar(
                        cat.title.replaceAll('\n', ' '),
                        'Browsing category products',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.textPrimary,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: AppDimensions.rounded12,
          border: Border.all(color: AppColors.borderMedium),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(height: 10),
            Text(title, style: AppTypography.subtitle.copyWith(fontSize: 13, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(subtitle, style: AppTypography.caption.copyWith(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
