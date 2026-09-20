import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../../../data/models/category_model.dart';
import '../controllers/home_controller.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.popularCategories.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore by Category',
                  style: AppTypography.sectionTitle.copyWith(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'See all',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Horizontal 2-Row Grid
          SizedBox(
            height: 220,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: (controller.popularCategories.length / 2).ceil(),
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, colIndex) {
                final firstItem = controller.popularCategories[colIndex * 2];
                final secondIndex = colIndex * 2 + 1;
                final secondItem = secondIndex < controller.popularCategories.length
                    ? controller.popularCategories[secondIndex]
                    : null;

                return Column(
                  children: [
                    _buildCategoryItem(firstItem),
                    const SizedBox(height: 12),
                    if (secondItem != null)
                      _buildCategoryItem(secondItem)
                    else
                      const SizedBox(height: 98, width: 82),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCategoryItem(CategoryModel category) {
    return InkWell(
      onTap: () {},
      borderRadius: AppDimensions.rounded12,
      child: SizedBox(
        width: 84,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: Color(category.backgroundColorHex ?? 0xFFFFF2EE),
                    borderRadius: AppDimensions.rounded16,
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: AppDimensions.rounded12,
                    child: category.iconUrl != null
                        ? CachedNetworkImage(
                            imageUrl: category.iconUrl!,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Icon(
                              Icons.medical_services_outlined,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          )
                        : const Icon(
                            Icons.medical_services_outlined,
                            color: AppColors.primary,
                            size: 28,
                          ),
                  ),
                ),
                if (category.badgeText != null)
                  Positioned(
                    top: -4,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: category.badgeType == BadgeType.red
                            ? AppColors.badgeRed
                            : AppColors.badgeOrange,
                        borderRadius: AppDimensions.rounded4,
                      ),
                      child: Text(
                        category.badgeText!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              category.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
