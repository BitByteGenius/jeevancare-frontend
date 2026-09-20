import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/product_card.dart';
import '../data/pharmacy_data.dart';

class DietNutritionSection extends StatefulWidget {
  const DietNutritionSection({super.key});

  @override
  State<DietNutritionSection> createState() => _DietNutritionSectionState();
}

class _DietNutritionSectionState extends State<DietNutritionSection> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients &&
        _scrollController.position.maxScrollExtent > 0) {
      setState(() {
        _scrollProgress = (_scrollController.position.pixels /
                _scrollController.position.maxScrollExtent)
            .clamp(0.0, 1.0);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = PharmacyData.dietNutritionProducts;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with "See all >"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Diet & nutrition',
                  style: AppTypography.headline2.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFEA580C),
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: Color(0xFFEA580C),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Horizontal Product Cards
          SizedBox(
            height: 335,
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  width: 175,
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Scrollbar indicator line
          Center(
            child: Container(
              width: 120,
              height: 3.5,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: _scrollProgress * 80,
                    child: Container(
                      width: 40,
                      height: 3.5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Tata 1mg Egg White Protein Banner (Screenshot 1)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 200,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFEF3C7),
                  Color(0xFFFDE68A),
                ],
              ),
              borderRadius: AppDimensions.rounded16,
              border: Border.all(color: const Color(0xFFFCD34D)),
            ),
            child: Stack(
              children: [
                // Protein packshot on right
                Positioned(
                  right: 12,
                  top: 14,
                  bottom: 14,
                  width: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: 'https://images.unsplash.com/photo-1579722820308-d74e571900a9?auto=format&fit=crop&w=400&q=80',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const SizedBox.shrink(),
                    ),
                  ),
                ),

                // Content on left
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 140, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // NEW LAUNCH badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDC2626),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'NEW LAUNCH',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Text(
                        'Egg-ceptional Protein\nExceptional Taste!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF78350F),
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 8),

                      const Text(
                        '24g Protein | Zero Eggy Taste\nTested For Banned Antibiotics',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF92400E),
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Shop Now',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
