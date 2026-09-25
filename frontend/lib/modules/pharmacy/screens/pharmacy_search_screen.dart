import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../data/models/product_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../data/pharmacy_data.dart';

class PharmacySearchScreen extends StatefulWidget {
  const PharmacySearchScreen({super.key});

  @override
  State<PharmacySearchScreen> createState() => _PharmacySearchScreenState();
}

class _PharmacySearchScreenState extends State<PharmacySearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.to;

    // Filter products from catalog if query typed
    final allProducts = [
      ...PharmacyData.spotlightProducts,
      ...PharmacyData.skinCareProducts,
      ...PharmacyData.dietNutritionProducts,
      ...PharmacyData.periodPmsProducts,
    ];

    final filteredProducts = _searchQuery.isEmpty
        ? <ProductModel>[]
        : allProducts.where((p) => p.name.toLowerCase().contains(_searchQuery.toLowerCase())).toSet().toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Search Box with Attached Ribbon (Screenshot 2)
            _buildSearchHeader(context),

            Expanded(
              child: _searchQuery.isNotEmpty
                  ? _buildSearchResults(filteredProducts, cartController)
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        const SizedBox(height: 12),

                        // 2. "Have a prescription? Order quickly!" Card (Screenshot 2)
                        _buildPrescriptionQuickCard(),

                        const SizedBox(height: 14),

                        // 3. ElevateHer Promotional Hero Banner (Screenshot 2)
                        _buildElevateHerBanner(),

                        const SizedBox(height: 20),

                        // 4. "In the spotlight" Section (Screenshot 2)
                        _buildSpotlightSection(cartController),

                        const SizedBox(height: 30),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Top Search Bar with attached purple/maroon ribbon (Screenshot 2)
  Widget _buildSearchHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      decoration: BoxDecoration(
        color: const Color(0xFF7A2326),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // White search box pill
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF0F172A), width: 1.2),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 20),
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val.trim();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search medicines & health products',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear, size: 18, color: Color(0xFF64748B)),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  ),
                const SizedBox(width: 8),
              ],
            ),
          ),

          // Attached Maroon Coupon Ribbon
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: const Text(
              'EXTRA 15% OFF on medicines with coupon',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // "Have a prescription? Order quickly!" Card (Screenshot 2)
  Widget _buildPrescriptionQuickCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.uploadPrescription),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFDCFCE7), width: 1.2),
          ),
          child: Row(
            children: [
              // Pink Medicine / Prescription Pad icon
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE7F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: Color(0xFFBE185D),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Have a prescription? Order quickly!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFFF5247),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ElevateHer Hero Banner (Screenshot 2)
  Widget _buildElevateHerBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 175,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E1744), Color(0xFF8B2635), Color(0xFFD97706)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Background banner image
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=800&q=80',
                  fit: BoxFit.cover,
                  color: Colors.black.withValues(alpha: 0.45),
                  colorBlendMode: BlendMode.darken,
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
                ),
              ),

              // Overlay content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'INTRODUCING',
                          style: TextStyle(color: Colors.white70, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 1.0),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(4)),
                          child: const Text('ICICI Lombard', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                            children: [
                              TextSpan(text: 'elevate'),
                              TextSpan(text: 'Her', style: TextStyle(color: Color(0xFFF43F5E), fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
                        const Text(
                          'WOMEN CARE',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.5),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'FOR EVERY HER, AT EVERY STAGE.',
                          style: TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF5247),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'BUY NOW',
                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                          ),
                        ),
                        const Spacer(),
                        const Text('Youth  •  Prime  •  Maternity  •  Midlife', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // "In the spotlight" Carousel (Screenshot 2)
  Widget _buildSpotlightSection(CartController cartController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text(
                'In the spotlight',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Ad',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: PharmacyData.spotlightProducts.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = PharmacyData.spotlightProducts[index];
              return _buildProductTile(product, cartController);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductTile(ProductModel product, CartController cartController) {
    return Container(
      width: 155,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: const Color(0xFFF8FAFC),
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => const Icon(Icons.spa, color: Colors.green),
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF15803D),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${product.rating}', style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 2),
                      const Icon(Icons.star, color: Colors.white, size: 9),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0F172A), height: 1.2),
          ),
          const SizedBox(height: 2),
          Text(product.packSize, style: const TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
          const Spacer(),
          Text(product.deliveryEta, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('₹${product.price.toInt()}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
              const SizedBox(width: 4),
              Text('₹${product.mrp.toInt()}', style: const TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8), decoration: TextDecoration.lineThrough)),
              const SizedBox(width: 4),
              Text('${product.discountPercent}% off', style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFF16A34A))),
            ],
          ),
          const SizedBox(height: 6),
          Obx(() {
            final qty = cartController.getQuantity(product.id);
            if (qty == 0) {
              return SizedBox(
                width: double.infinity,
                height: 30,
                child: OutlinedButton(
                  onPressed: () => cartController.addToCart(product),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFF5247)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text('ADD', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFFFF5247))),
                ),
              );
            } else {
              return Container(
                height: 30,
                decoration: BoxDecoration(color: const Color(0xFFFF5247), borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.remove, size: 14, color: Colors.white), padding: EdgeInsets.zero, onPressed: () => cartController.decrementQuantity(product.id)),
                    Text('$qty', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.add, size: 14, color: Colors.white), padding: EdgeInsets.zero, onPressed: () => cartController.addToCart(product)),
                  ],
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  // Instant Live Search Results
  Widget _buildSearchResults(List<ProductModel> results, CartController cartController) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off_rounded, size: 54, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            Text('No products found for "$_searchQuery"', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
            const SizedBox(height: 4),
            const Text('Check for spelling errors or try searching for another medicine', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (context, index) => const Divider(height: 24, color: Color(0xFFF1F5F9)),
      itemBuilder: (context, index) {
        final item = results[index];
        return InkWell(
          onTap: () => Get.toNamed(AppRoutes.productDetails, arguments: item),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 60,
                  height: 60,
                  color: const Color(0xFFF8FAFC),
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => const Icon(Icons.medication, color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                    const SizedBox(height: 2),
                    Text(item.packSize, style: const TextStyle(fontSize: 11.5, color: Color(0xFF64748B))),
                    const SizedBox(height: 4),
                    Text('₹${item.price.toInt()}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () => cartController.addToCart(item),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFF5247)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                ),
                child: const Text('ADD', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFFFF5247))),
              ),
            ],
          ),
        );
      },
    );
  }
}
