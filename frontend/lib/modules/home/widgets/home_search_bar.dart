import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/constants/app_constants.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../controllers/home_controller.dart';
import 'upload_prescription_sheet.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.surface,
      child: Row(
        children: [
          // Search Input Box
          Expanded(
            child: InkWell(
              onTap: () {
                _showSearchDialog(context);
              },
              borderRadius: AppDimensions.roundedFull,
              child: Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppDimensions.roundedFull,
                  border: Border.all(color: AppColors.borderMedium, width: 1.2),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Obx(() {
                        final placeholderIndex = controller.searchHintIndex.value;
                        final hint = AppConstants.searchPlaceholders[placeholderIndex];

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.0, 0.5),
                                end: Offset.zero,
                              ).animate(animation),
                              child: FadeTransition(opacity: animation, child: child),
                            );
                          },
                          child: Text(
                            hint,
                            key: ValueKey<String>(hint),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.bodyRegular.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12.5,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Upload Prescription Action Pill
          InkWell(
            onTap: () => UploadPrescriptionSheet.show(context),
            borderRadius: AppDimensions.roundedFull,
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: AppDimensions.roundedFull,
                border: Border.all(color: AppColors.borderMedium),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.file_upload_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upload',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        'Prescription',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.85,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search for medicines, health products...',
                      hintStyle: AppTypography.bodyRegular,
                      prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.surfaceSubtle,
                      border: OutlineInputBorder(
                        borderRadius: AppDimensions.roundedFull,
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Popular Searches',
                style: AppTypography.subtitle,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'Paracetamol',
                'Vitamin D3',
                'Whey Protein',
                'BP Monitor',
                'Digene',
                'Hair Gummies',
                'Glucometer',
              ].map((term) {
                return ActionChip(
                  label: Text(term, style: const TextStyle(fontSize: 12)),
                  backgroundColor: AppColors.surfaceSubtle,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppDimensions.roundedFull,
                    side: const BorderSide(color: AppColors.borderLight),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
