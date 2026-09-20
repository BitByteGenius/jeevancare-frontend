import 'package:flutter/material.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../core/widgets/product_card.dart';
import '../data/pharmacy_data.dart';

class PetArrivalsSection extends StatefulWidget {
  const PetArrivalsSection({super.key});

  @override
  State<PetArrivalsSection> createState() => _PetArrivalsSectionState();
}

class _PetArrivalsSectionState extends State<PetArrivalsSection> {
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
    final products = PharmacyData.petArrivalsProducts;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Get your paws on latest arrivals" Banner
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFFECEB),
                  Color(0xFFFDE8F1),
                ],
              ),
              borderRadius: AppDimensions.rounded16,
              border: Border.all(color: const Color(0xFFFFD4E2)),
            ),
            child: Row(
              children: [
                // Pet food pack icon
                Container(
                  width: 44,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEA580C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pets, size: 20, color: Colors.white),
                      SizedBox(height: 2),
                      Icon(Icons.star, size: 10, color: Colors.white70),
                    ],
                  ),
                ),
                const SizedBox(width: 14),

                // Text
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get your paws',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF6B21A8),
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        'on latest arrivals',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF7E22CE),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Puppy graphic representation
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFDDD2),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.pets_rounded,
                      size: 26,
                      color: Color(0xFFD97706),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

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

          // Slider Indicator Bar at the bottom
          Center(
            child: Container(
              width: 140,
              height: 3.5,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: _scrollProgress * 95,
                    child: Container(
                      width: 45,
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
        ],
      ),
    );
  }
}
