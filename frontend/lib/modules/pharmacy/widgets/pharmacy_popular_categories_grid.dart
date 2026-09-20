import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../data/pharmacy_data.dart';

class PharmacyPopularCategoriesGrid extends StatelessWidget {
  final Function(String categoryId)? onCategoryTap;

  const PharmacyPopularCategoriesGrid({
    super.key,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final categories = PharmacyData.popularCategories;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular categories',
            style: AppTypography.headline2.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          // 4-Column Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 14,
              crossAxisSpacing: 10,
              childAspectRatio: 0.65, // Card container + label below
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return InkWell(
                onTap: () => onCategoryTap?.call(category.id),
                borderRadius: AppDimensions.rounded12,
                child: Column(
                  children: [
                    // Peach Card with Packshot & Badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 76,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF1ED), // Warm peach
                            borderRadius: AppDimensions.rounded12,
                            border: Border.all(
                              color: const Color(0xFFFFDFD6).withValues(alpha: 0.7),
                            ),
                          ),
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: category.iconUrl ?? '',
                              fit: BoxFit.contain,
                              placeholder: (context, url) => Center(
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFDFD6),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.medication_rounded,
                                size: 30,
                                color: Color(0xFFF97316),
                              ),
                            ),
                          ),
                        ),

                        // Badge positioned at bottom of the card like in Screenshot 5
                        if (category.badgeText != null)
                          Positioned(
                            left: 2,
                            right: 2,
                            bottom: -1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              decoration: BoxDecoration(
                                color: category.badgeText == 'New'
                                    ? const Color(0xFFD946EF) // Magenta for New
                                    : const Color(0xFFF97316), // Orange for Trending / Must Have / Best Seller
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                category.badgeText!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Label
                    Expanded(
                      child: Text(
                        category.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                          height: 1.15,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
