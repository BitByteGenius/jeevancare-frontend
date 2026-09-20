import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/product_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../data/pharmacy_data.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryTitle;

  const CategoryProductsScreen({
    super.key,
    this.categoryTitle = 'Period & PMS',
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  int _selectedSubcategoryIndex = 0;
  final List<String> _skinSubcategories = [
    'Face wash',
    'Top Picks',
    'Sunscreen',
    'Moisturizers',
    'Serums',
    'Toner',
  ];

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.to;
    final isSkinCare = widget.categoryTitle.toLowerCase().contains('skin') ||
        widget.categoryTitle.toLowerCase().contains('face');
    final products = isSkinCare
        ? PharmacyData.skinCareProducts
        : PharmacyData.periodPmsProducts;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
        ),
        title: Text(
          widget.categoryTitle,
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded, color: Color(0xFF0F172A)),
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.cart),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_bag_outlined, color: Color(0xFF0F172A)),
                Obx(() {
                  final count = cartController.totalItemCount;
                  if (count == 0) return const SizedBox.shrink();
                  return Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Center(
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Filter Chips Bar (Screenshot 3 & 5)
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE2E8F0), width: 0.8),
                  ),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFilterPill(icon: Icons.swap_vert_rounded, label: 'Sort'),
                    const SizedBox(width: 8),
                    _buildFilterPill(icon: Icons.tune_rounded, label: 'All filters'),
                    if (isSkinCare) ...[
                      const SizedBox(width: 8),
                      _buildFilterPill(label: 'Acne Control Cleansers'),
                      const SizedBox(width: 8),
                      _buildFilterPill(label: 'Oil Control'),
                    ],
                  ],
                ),
              ),

              // Main Body: Split View (if Skin Care) or Full Width (if Period & PMS)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Optional Left Subcategory Rail (Screenshot 5)
                    if (isSkinCare)
                      Container(
                        width: 78,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8FAFC),
                          border: Border(
                            right: BorderSide(color: Color(0xFFE2E8F0), width: 0.8),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: _skinSubcategories.length,
                          itemBuilder: (context, index) {
                            final isSel = _selectedSubcategoryIndex == index;
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedSubcategoryIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                                decoration: BoxDecoration(
                                  color: isSel ? Colors.white : Colors.transparent,
                                  border: Border(
                                    right: BorderSide(
                                      color: isSel ? const Color(0xFF9E1A5F) : Colors.transparent,
                                      width: 3.5,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: isSel ? const Color(0xFFFCE7F3) : Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: const Color(0xFFE2E8F0)),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.spa_rounded,
                                          size: 18,
                                          color: isSel ? const Color(0xFF9E1A5F) : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _skinSubcategories[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: isSel ? FontWeight.w800 : FontWeight.w500,
                                        color: isSel ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    // Products List
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 70), // Bottom padding for coupon bar
                        itemCount: products.length + (isSkinCare ? 1 : 0),
                        separatorBuilder: (context, index) => const Divider(
                          color: Color(0xFFE2E8F0),
                          height: 24,
                          thickness: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          // Banner at index 0 for Skin Care
                          if (isSkinCare && index == 0) {
                            return _buildSkinCareBanner();
                          }
                          final product = isSkinCare ? products[index - 1] : products[index];
                          return _buildProductRow(product, cartController);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Bottom Floating Coupon Bar (Screenshots 3 & 5)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                Get.snackbar(
                  'Coupon Applied: EXTRA15',
                  '15% discount applied on eligible health products!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF881337),
                  colorText: Colors.white,
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 50),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFF881337), // Plum / maroon strip
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.keyboard_arrow_up, size: 14, color: Color(0xFF881337)),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Apply coupon to get ',
                      style: TextStyle(fontSize: 11.5, color: Colors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'EXTRA 15% OFF',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ),
                    const Text(
                      ' on medicines',
                      style: TextStyle(fontSize: 11.5, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPill({IconData? icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: 4),
            Icon(icon, size: 14, color: const Color(0xFF475569)),
          ],
        ],
      ),
    );
  }

  Widget _buildSkinCareBanner() {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        ),
        borderRadius: AppDimensions.rounded12,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Simple',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF2E7D32)),
                ),
                const Text(
                  'GENTLE CLEANSE\nFOR SENSITIVE SKIN',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1B5E20), height: 1.1),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFF2E7D32), borderRadius: BorderRadius.circular(4)),
                  child: const Text('UP TO 50% OFF | SAVE25', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            bottom: 10,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80',
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(ProductModel product, CartController cartController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image with rating badge
        Container(
          width: 90,
          height: 110,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Center(
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => const Icon(
                Icons.medical_services_rounded,
                size: 32,
                color: Color(0xFF94A3B8),
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
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                product.packSize,
                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 3),

              // Rating pill if ratings exist
              if (product.ratingCount != null)
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16A34A),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.star, size: 9, color: Colors.white),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${product.ratingCount} ratings',
                      style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                    ),
                  ],
                ),
              const SizedBox(height: 3),

              Text(
                product.deliveryEta,
                style: const TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8)),
              ),
              const SizedBox(height: 6),

              // Price Row
              Row(
                children: [
                  Text(
                    Formatters.formatCurrency(product.price),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    Formatters.formatCurrency(product.mrp),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF94A3B8),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  if (product.discountPercent > 0) ...[
                    const SizedBox(width: 6),
                    Text(
                      '${product.discountPercent}% off',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF16A34A)),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 6),

              // Care Plan chip
              if (product.carePlanPrice != null)
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBE123C),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        Formatters.formatCurrency(product.carePlanPrice!),
                        style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'order for ${Formatters.formatCurrency(product.carePlanThreshold ?? 1200)}',
                      style: const TextStyle(fontSize: 10, color: Color(0xFFBE123C), fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              const SizedBox(height: 10),

              // ADD button
              Obx(() {
                final qty = cartController.getQuantity(product.id);
                if (qty == 0) {
                  return SizedBox(
                    width: 100,
                    height: 32,
                    child: OutlinedButton(
                      onPressed: () => cartController.addToCart(product),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary, width: 1.2),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text(
                        'ADD',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: 100,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => cartController.decrementQuantity(product.id),
                          icon: const Icon(Icons.remove, size: 14, color: Colors.white),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Text(
                          '$qty',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () => cartController.addToCart(product),
                          icon: const Icon(Icons.add, size: 14, color: Colors.white),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ],
    );
  }
}
