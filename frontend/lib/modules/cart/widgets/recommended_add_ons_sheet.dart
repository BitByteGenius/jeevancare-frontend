import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../controllers/cart_controller.dart';

void showRecommendedAddOnsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => const RecommendedAddOnsSheet(),
  );
}

class RecommendedAddOnsSheet extends StatelessWidget {
  const RecommendedAddOnsSheet({super.key});

  static const List<ProductModel> _recommendedItems = [
    ProductModel(
      id: 'rec_neem_men',
      name: 'Himalaya Men Pimple Clear Neem Face Wash',
      packSize: '100 ml Face Wash',
      rating: 4.1,
      ratingCount: 335,
      imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80',
      price: 183,
      mrp: 189,
      discountPercent: 3,
      deliveryEta: 'Get by Thu, 24 Sep',
      category: 'skin_care',
    ),
    ProductModel(
      id: 'rec_kesar_glow',
      name: 'Himalaya Natural Glow Kesar Face Wash',
      packSize: '50 ml Face Wash',
      rating: 4.0,
      ratingCount: 39,
      imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80',
      price: 87.2,
      mrp: 90,
      discountPercent: 3,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 78.5,
      carePlanThreshold: 1200,
      category: 'skin_care',
    ),
    ProductModel(
      id: 'rec_tan_orange',
      name: 'Himalaya Tan Removal Orange Face Wash',
      packSize: '100 ml Face Wash',
      rating: 4.2,
      ratingCount: 712,
      imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80',
      price: 220,
      mrp: 220,
      discountPercent: 0,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 198,
      carePlanThreshold: 1200,
      category: 'skin_care',
    ),
    ProductModel(
      id: 'rec_dettol_soap',
      name: 'Dettol Original Germ Protection Mega Saver Pack of Bathing Soap Bar (100gm Each)',
      packSize: '4 Packs',
      rating: 4.3,
      ratingCount: 186,
      imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=300&q=80',
      price: 172,
      mrp: 180,
      discountPercent: 4,
      deliveryEta: 'Get by Thu, 24 Sep',
      category: 'skin_care',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.to;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with Title & Close Button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recommended for you',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Icon(Icons.close, size: 18, color: Color(0xFF1E293B)),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Items List
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _recommendedItems.length,
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomPaint(
                  size: const Size(double.infinity, 1),
                  painter: _DottedLinePainter(),
                ),
              ),
              itemBuilder: (context, index) {
                final item = _recommendedItems[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 75,
                        height: 90,
                        color: const Color(0xFFF8FAFC),
                        child: CachedNetworkImage(
                          imageUrl: item.imageUrl,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.spa_rounded,
                            color: Color(0xFF10B981),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.packSize,
                            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                          ),
                          const SizedBox(height: 5),

                          // Rating Row
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF15803D),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${item.rating}',
                                      style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 2),
                                    const Icon(Icons.star, color: Colors.white, size: 10),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${item.ratingCount} ratings',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          Text(
                            item.deliveryEta,
                            style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                          ),
                          const SizedBox(height: 6),

                          // Price Row
                          Row(
                            children: [
                              Text(
                                '₹${item.price.toStringAsFixed(item.price.truncateToDouble() == item.price ? 0 : 1)}',
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              if (item.mrp > item.price) ...[
                                const SizedBox(width: 6),
                                Text(
                                  '₹${item.mrp.toInt()}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF94A3B8),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${item.discountPercent}% off',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF16A34A),
                                  ),
                                ),
                              ],
                            ],
                          ),

                          // Care Plan pill if available
                          if (item.carePlanPrice != null) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF7A2326),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '₹${item.carePlanPrice!.toStringAsFixed(item.carePlanPrice!.truncateToDouble() == item.carePlanPrice! ? 0 : 1)} order for ₹${item.carePlanThreshold ?? 1200}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // ADD Button
                    Obx(() {
                      final qty = cartController.getQuantity(item.id);
                      if (qty == 0) {
                        return OutlinedButton(
                          onPressed: () => cartController.addToCart(item),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFFF5247)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            minimumSize: const Size(64, 32),
                          ),
                          child: const Text(
                            'ADD',
                            style: TextStyle(
                              color: Color(0xFFFF5247),
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF5247),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 14, color: Colors.white),
                                constraints: const BoxConstraints(minWidth: 26, minHeight: 28),
                                padding: EdgeInsets.zero,
                                onPressed: () => cartController.decrementQuantity(item.id),
                              ),
                              Text(
                                '$qty',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, size: 14, color: Colors.white),
                                constraints: const BoxConstraints(minWidth: 26, minHeight: 28),
                                padding: EdgeInsets.zero,
                                onPressed: () => cartController.addToCart(item),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                  ],
                );
              },
            ),
          ),

          // Sticky Coral Red "Skip & continue" Button
          Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 14),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Get.toNamed(AppRoutes.cart);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5247),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text(
                  'Skip & continue',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.0;

    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
