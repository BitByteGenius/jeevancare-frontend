import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../controllers/home_controller.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.banners.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          SizedBox(
            height: 168,
            child: PageView.builder(
              itemCount: controller.banners.length,
              onPageChanged: (index) => controller.updateBannerIndex(index),
              itemBuilder: (context, index) {
                final banner = controller.banners[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(banner.backgroundColorHex),
                      borderRadius: AppDimensions.rounded16,
                      boxShadow: AppDimensions.subtleShadow,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        // Background soft decorative glow
                        Positioned(
                          right: -30,
                          bottom: -30,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.35),
                            ),
                          ),
                        ),

                        // Image on the right
                        Positioned(
                          right: 12,
                          bottom: 0,
                          top: 0,
                          child: SizedBox(
                            width: 130,
                            child: CachedNetworkImage(
                              imageUrl: banner.imageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(
                                Icons.health_and_safety_rounded,
                                size: 60,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),

                        // Content on the left
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.54,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (banner.tag != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    margin: const EdgeInsets.only(bottom: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(alpha: 0.15),
                                      borderRadius: AppDimensions.rounded4,
                                    ),
                                    child: Text(
                                      banner.tag!.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryDark,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                Text(
                                  banner.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.headline2.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (banner.subtitle != null)
                                  Text(
                                    banner.subtitle!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.caption.copyWith(
                                      fontSize: 11,
                                      color: AppColors.textSecondary,
                                      height: 1.25,
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 28,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.textPrimary,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: AppDimensions.roundedFull,
                                      ),
                                    ),
                                    child: Text(
                                      banner.ctaText ?? 'Shop now',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Indicator dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.banners.length,
              (index) {
                final isSelected = controller.currentBannerIndex.value == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: isSelected ? 22 : 6,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.borderMedium,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
