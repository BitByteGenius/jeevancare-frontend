import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../../../data/models/category_model.dart';
import '../controllers/home_controller.dart';

class HealthyFoodsGrid extends StatelessWidget {
  const HealthyFoodsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.healthyFoods.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Healthy foods',
              style: AppTypography.sectionTitle.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.healthyFoods.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 14,
                childAspectRatio: 0.76,
              ),
              itemBuilder: (context, index) {
                final food = controller.healthyFoods[index];
                return _buildFoodCard(food);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFoodCard(CategoryModel food) {
    return InkWell(
      onTap: () {},
      borderRadius: AppDimensions.rounded12,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(food.backgroundColorHex),
                    borderRadius: AppDimensions.rounded12,
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: AppDimensions.rounded8,
                    child: CachedNetworkImage(
                      imageUrl: food.iconUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.restaurant_rounded,
                        color: AppColors.primary,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                if (food.badgeText != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      decoration: const BoxDecoration(
                        color: Color(0xFF993B12), // Deep brown/orange pill from screenshot
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppDimensions.radius12),
                          bottomRight: Radius.circular(AppDimensions.radius12),
                        ),
                      ),
                      child: Text(
                        food.badgeText!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            food.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
