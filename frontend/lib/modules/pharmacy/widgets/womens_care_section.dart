import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../app/theme/app_dimensions.dart';
import '../data/pharmacy_data.dart';

class WomensCareSection extends StatelessWidget {
  const WomensCareSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = PharmacyData.womensCareItems;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with illustration and purple underline
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nurture your well-being with',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Women's Care Essentials",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Purple accent line
                  Container(
                    width: 70,
                    height: 3.5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B21A8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),

              // Decorative graphic on the right
              Positioned(
                right: 0,
                top: -10,
                child: SizedBox(
                  width: 60,
                  height: 48,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 4,
                        child: Container(
                          width: 32,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCE7F3),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFF472B6)),
                          ),
                          child: const Center(
                            child: Icon(Icons.favorite_rounded, size: 16, color: Color(0xFFDB2777)),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 18,
                        top: 10,
                        child: Container(
                          width: 34,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFF86EFAC),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                            child: Icon(Icons.circle, size: 14, color: Color(0xFF15803D)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 2x3 Lavender Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 14,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                onTap: () {},
                borderRadius: AppDimensions.rounded12,
                child: Column(
                  children: [
                    // Lavender container with product packshot
                    Container(
                      width: double.infinity,
                      height: 96,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3EDFF), // Soft lilac
                        borderRadius: AppDimensions.rounded12,
                        border: Border.all(color: const Color(0xFFE5DAFD)),
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: item.imageUrl,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Icon(
                              Icons.spa_rounded,
                              size: 32,
                              color: Color(0xFF7C3AED),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Expanded(
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                          height: 1.2,
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
