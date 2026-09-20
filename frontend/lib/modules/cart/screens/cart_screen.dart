import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../data/models/product_model.dart';
import '../controllers/cart_controller.dart';
import '../widgets/care_plan_upsell_sheet.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _activeBeforeCheckoutTab = 0; // 0 = In the spotlight, 1 = Last Minute Buys
  bool _carePlanExpanded = false;

  // Spotlight and Last Minute products for "Before you checkout"
  static const List<ProductModel> _spotlightProducts = [
    ProductModel(
      id: 'spotlight_moringa',
      name: 'Organic India Moringa Powder | Manages Weakness, Fatigue & I...',
      packSize: '100 gm Powder',
      rating: 4.3,
      ratingCount: 380,
      imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=300&q=80',
      price: 248,
      mrp: 275,
      discountPercent: 10,
      deliveryEta: 'Get by Thu, 24 Sep',
      category: 'herbal',
    ),
    ProductModel(
      id: 'spotlight_horlicks',
      name: 'Horlicks Diabetes Plus Powder Helps Manage Blood Sugar Vanilla',
      packSize: '400 gm Powder',
      rating: 4.5,
      ratingCount: 520,
      imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=300&q=80',
      price: 672,
      mrp: 820,
      discountPercent: 18,
      deliveryEta: 'Get by Thu, 24 Sep',
      category: 'nutrition',
    ),
    ProductModel(
      id: 'spotlight_centrum',
      name: 'Centrum Multivitamin for Men with Zinc, Vitamin C & Minerals',
      packSize: '50 tablets',
      rating: 4.3,
      ratingCount: 890,
      imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=300&q=80',
      price: 576,
      mrp: 720,
      discountPercent: 20,
      deliveryEta: 'Get by Thu, 24 Sep',
      category: 'vitamins',
    ),
  ];

  static const List<ProductModel> _lastMinuteProducts = [
    ProductModel(
      id: 'lm_vicks_vaporub',
      name: 'Vicks VapoRub Relief from Cold, Cough, Headache & Body Ache',
      packSize: '50 ml Balm',
      rating: 4.7,
      ratingCount: 1420,
      imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=300&q=80',
      price: 155,
      mrp: 170,
      discountPercent: 9,
      deliveryEta: 'Get by Thu, 24 Sep',
      category: 'cold_cough',
    ),
    ProductModel(
      id: 'lm_bandaid_washproof',
      name: 'Band-Aid Washproof Medicated Dressing Adhesive Strips',
      packSize: '20 Bandages',
      rating: 4.6,
      ratingCount: 850,
      imageUrl: 'https://images.unsplash.com/photo-1603398938378-e54eab446dde?auto=format&fit=crop&w=300&q=80',
      price: 65,
      mrp: 75,
      discountPercent: 13,
      deliveryEta: 'Get by Thu, 24 Sep',
      category: 'first_aid',
    ),
    ProductModel(
      id: 'lm_himalaya_lip_balm',
      name: 'Himalaya Herbals Nourishing Lip Balm with Carrot Seed Oil',
      packSize: '10 gm Tube',
      rating: 4.4,
      ratingCount: 920,
      imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80',
      price: 45,
      mrp: 50,
      discountPercent: 10,
      deliveryEta: 'Get by Thu, 24 Sep',
      category: 'skin_care',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.to;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Obx(() => GestureDetector(
              onTap: () => _showLocationPicker(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.navigation_rounded, size: 14, color: Color(0xFFFF5247)),
                    const SizedBox(width: 5),
                    Text(
                      cartController.selectedAddress.value,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF64748B)),
                  ],
                ),
              ),
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF0F172A)),
            onPressed: () {
              Get.rawSnackbar(
                messageText: const Text('Search in cart or add more products', style: TextStyle(color: Colors.white)),
                backgroundColor: AppColors.textPrimary,
                borderRadius: 8,
                margin: const EdgeInsets.all(16),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Obx(() {
        if (cartController.items.isEmpty) {
          return _buildEmptyCart(context);
        }

        final items = cartController.items.values.toList();

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // 1. Delivery Promise Pill
                  _buildDeliveryPromisePill(),

                  // Dotted separator line
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomPaint(
                      size: const Size(double.infinity, 1),
                      painter: _CartDottedLinePainter(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 2. Cart Items List
                  ...items.map((cartItem) => _buildCartItemCard(cartItem, cartController)),

                  // Divider band
                  const Divider(thickness: 8, color: Color(0xFFF8FAFC), height: 8),

                  // 3. Apply Coupon Card
                  _buildApplyCouponCard(context),

                  // Divider band
                  const Divider(thickness: 8, color: Color(0xFFF8FAFC), height: 8),

                  // 4. Care Plan Card
                  _buildCarePlanCard(context, cartController),

                  // Divider band
                  const Divider(thickness: 8, color: Color(0xFFF8FAFC), height: 8),

                  // 5. "Before you checkout" Section
                  _buildBeforeYouCheckoutSection(cartController),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            // 6. Sticky Bottom Action Bar: "Login to continue"
            _buildStickyBottomBar(context, cartController),
          ],
        );
      }),
    );
  }

  // Delivery Promise Pill (Screenshot 5)
  Widget _buildDeliveryPromisePill() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFDCFCE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.timer_outlined, size: 15, color: Color(0xFF16A34A)),
            ),
            const SizedBox(width: 10),
            const Text(
              'Delivering by 24 - 26 september',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Cart Item Card (Screenshot 5)
  Widget _buildCartItemCard(CartItemModel cartItem, CartController cartController) {
    final p = cartItem.product;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail Image
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: p.imageUrl,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => const Icon(
                  Icons.spa_rounded,
                  color: Color(0xFF10B981),
                  size: 28,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Title and pack size
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
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
                  p.packSize,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Quantity dropdown and Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Quantity Picker Dropdown button [ 1 ⌄ ]
              GestureDetector(
                onTap: () => _showQuantityBottomSheet(context, p.id, cartItem.quantity, cartController),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${cartItem.quantity}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFFF5247),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: Color(0xFFFF5247),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Price Row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '₹${(p.mrp * cartItem.quantity).toInt()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '₹${(p.price * cartItem.quantity).toInt()}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Apply Coupon Card (Screenshot 5)
  Widget _buildApplyCouponCard(BuildContext context) {
    return InkWell(
      onTap: () => _showCouponBottomSheet(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.local_offer_outlined,
                size: 20,
                color: Color(0xFF16A34A),
              ),
            ),
            const SizedBox(width: 14),
            const Text(
              'Apply coupon',
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFFF5247),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  // Care Plan Card (Screenshot 5)
  Widget _buildCarePlanCard(BuildContext context, CartController cartController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7ED),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFED7AA).withValues(alpha: 0.6)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Save ₹67 extra with [Care Plan]
            Row(
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                    children: [
                      TextSpan(text: 'Save '),
                      TextSpan(
                        text: '₹67 extra ',
                        style: TextStyle(color: Color(0xFF00785C), fontWeight: FontWeight.w900),
                      ),
                      TextSpan(text: 'with '),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7A2326),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Care Plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Benefit 1: Extra 4% off [on all products]
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E8FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.card_giftcard_rounded,
                    size: 18,
                    color: Color(0xFF7C3AED),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Extra 4% off ',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'on all products',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Benefit 2: Free & Faster delivery
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E8FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.local_shipping_rounded,
                    size: 18,
                    color: Color(0xFF7C3AED),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Free & Faster delivery',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // "More benefits ⌄" expandable link
            GestureDetector(
              onTap: () {
                setState(() {
                  _carePlanExpanded = !_carePlanExpanded;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'More benefits',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8D5B39),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Color(0xFF8D5B39),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _carePlanExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            if (_carePlanExpanded) ...[
              const SizedBox(height: 8),
              const Text(
                '• Guaranteed lowest medicine prices\n• Free tele-consultations with certified MBBS doctors\n• Zero delivery fees on 20 consecutive orders',
                style: TextStyle(fontSize: 11.5, color: Color(0xFF78350F), height: 1.4),
              ),
            ],

            const SizedBox(height: 14),

            // Bottom row: 3 months at ₹165 ₹549 + [Add plan] button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      '3 months at ',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF334155)),
                    ),
                    Text(
                      '₹165 ',
                      style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                    ),
                    Text(
                      '₹549',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF94A3B8),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  final isActive = cartController.isCarePlanActive.value;
                  return SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isActive) {
                          cartController.toggleCarePlan();
                        } else {
                          showCarePlanUpsellModal(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isActive ? const Color(0xFF16A34A) : const Color(0xFF1E242B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: Text(
                        isActive ? 'Plan Added ✓' : 'Add plan',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // "Before you checkout" Section (Screenshot 5)
  Widget _buildBeforeYouCheckoutSection(CartController cartController) {
    final activeProducts = _activeBeforeCheckoutTab == 0 ? _spotlightProducts : _lastMinuteProducts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row with blue cart icon
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 18,
                  color: Color(0xFF0284C7),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Before you checkout',
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),

        // Filter Pills: [In the spotlight] [Last Minute Buys]
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _activeBeforeCheckoutTab = 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: _activeBeforeCheckoutTab == 0 ? const Color(0xFF0F172A) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _activeBeforeCheckoutTab == 0 ? const Color(0xFF0F172A) : const Color(0xFFCBD5E1),
                    ),
                  ),
                  child: Text(
                    'In the spotlight',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _activeBeforeCheckoutTab == 0 ? Colors.white : const Color(0xFF334155),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() => _activeBeforeCheckoutTab = 1),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: _activeBeforeCheckoutTab == 1 ? const Color(0xFF0F172A) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _activeBeforeCheckoutTab == 1 ? const Color(0xFF0F172A) : const Color(0xFFCBD5E1),
                    ),
                  ),
                  child: Text(
                    'Last Minute Buys',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _activeBeforeCheckoutTab == 1 ? Colors.white : const Color(0xFF334155),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Horizontal Product Cards Carousel
        SizedBox(
          height: 290,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: activeProducts.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = activeProducts[index];
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
                    // Top: "Ad" badge + Image
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 105,
                            width: double.infinity,
                            color: const Color(0xFFF8FAFC),
                            child: CachedNetworkImage(
                              imageUrl: product.imageUrl,
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) => const Icon(
                                Icons.medication_liquid_rounded,
                                color: Color(0xFF10B981),
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Ad',
                              style: TextStyle(
                                fontSize: 9.5,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        // Rating badge on bottom left of image
                        Positioned(
                          bottom: 4,
                          left: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF15803D),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${product.rating}',
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 2),
                                const Icon(Icons.star, color: Colors.white, size: 9),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Name
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Pack size
                    Text(
                      product.packSize,
                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),

                    const Spacer(),

                    // ETA
                    Text(
                      product.deliveryEta,
                      style: const TextStyle(fontSize: 10.5, color: Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 4),

                    // Price
                    Row(
                      children: [
                        Text(
                          '₹${product.price.toInt()}',
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '₹${product.mrp.toInt()}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF94A3B8),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${product.discountPercent}% off',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // ADD Button
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
                            child: const Text(
                              'ADD',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFFF5247),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF5247),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 14, color: Colors.white),
                                padding: EdgeInsets.zero,
                                onPressed: () => cartController.decrementQuantity(product.id),
                              ),
                              Text(
                                '$qty',
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, size: 14, color: Colors.white),
                                padding: EdgeInsets.zero,
                                onPressed: () => cartController.addToCart(product),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Sticky Bottom Bar: "Login to continue" (Screenshot 5)
  Widget _buildStickyBottomBar(BuildContext context, CartController cartController) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
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
            _showCheckoutOrLoginDialog(context, cartController);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5247),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
          ),
          child: const Text(
            'Login to continue',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Empty Cart View
  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 48,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore genuine medicines and healthcare essentials',
            style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5247),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Start Shopping', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Quantity Picker Bottom Sheet
  void _showQuantityBottomSheet(BuildContext context, String productId, int currentQty, CartController cartController) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Quantity',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(ctx).pop(),
                  child: const Icon(Icons.close, color: Color(0xFF64748B)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(6, (i) {
                final qty = i + 1;
                final isSelected = qty == currentQty;
                return ChoiceChip(
                  label: Text('$qty', style: TextStyle(fontWeight: FontWeight.w700, color: isSelected ? Colors.white : const Color(0xFF0F172A))),
                  selected: isSelected,
                  selectedColor: const Color(0xFFFF5247),
                  backgroundColor: const Color(0xFFF1F5F9),
                  onSelected: (selected) {
                    cartController.setQuantity(productId, qty);
                    Navigator.of(ctx).pop();
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                cartController.removeFromCart(productId);
                Navigator.of(ctx).pop();
              },
              icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
              label: const Text('Remove from cart', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }

  // Coupon Picker Modal
  void _showCouponBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Available Coupons', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF86EFAC)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_offer_rounded, color: Color(0xFF16A34A)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('EXTRA 10% OFF', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF16A34A))),
                        SizedBox(height: 2),
                        Text('Flat 10% instant discount on health & wellness products', style: TextStyle(fontSize: 11, color: Color(0xFF475569))),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Get.rawSnackbar(
                        messageText: const Text('Coupon EXTRA10 applied successfully!', style: TextStyle(color: Colors.white)),
                        backgroundColor: const Color(0xFF16A34A),
                        borderRadius: 8,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                    child: const Text('APPLY', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF16A34A))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Location Selector
  void _showLocationPicker(BuildContext context) {
    final cartController = CartController.to;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Delivery Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),
            ListTile(
              leading: const Icon(Icons.location_on, color: Color(0xFFFF5247)),
              title: const Text('Buxar (Default)', style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: const Text('Station Road, Buxar, Bihar 802101'),
              onTap: () {
                cartController.selectedAddress.value = 'Buxar';
                Navigator.of(ctx).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_city, color: Color(0xFF64748B)),
              title: const Text('Patna Central', style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: const Text('Bailey Road, Patna, Bihar 800001'),
              onTap: () {
                cartController.selectedAddress.value = 'Patna';
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCheckoutOrLoginDialog(BuildContext context, CartController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Login to proceed with order', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
            const SizedBox(height: 6),
            const Text('Enter your mobile number to receive OTP and unlock genuine medicine delivery to your door', style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B))),
            const SizedBox(height: 18),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixText: '+91 ',
                prefixStyle: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                hintText: 'Enter 10-digit mobile number',
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Get.rawSnackbar(
                    messageText: const Text('OTP sent! Order placed with 100% Genuine Medicine Guarantee.', style: TextStyle(color: Colors.white)),
                    backgroundColor: const Color(0xFF16A34A),
                    borderRadius: 8,
                    margin: const EdgeInsets.all(16),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5247),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Get OTP & Continue', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartDottedLinePainter extends CustomPainter {
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
