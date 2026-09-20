import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/product_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/widgets/recommended_add_ons_sheet.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel? product;

  const ProductDetailsScreen({
    super.key,
    this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedSizeIndex = 0;
  int _selectedTabPill = 0;
  int _selectedRecCategory = 0;
  bool _isExpandedDescription = false;
  final ScrollController _recScrollController = ScrollController();
  double _recScrollProgress = 0.0;

  final List<String> _sizes = [
    '400 ml Face Wash',
    '50 ml Face Wash',
    '100 ml Face Wash',
  ];

  late final ProductModel _activeProduct;

  @override
  void initState() {
    super.initState();
    _activeProduct = widget.product ??
        (Get.arguments is ProductModel
            ? Get.arguments as ProductModel
            : const ProductModel(
                id: 'himalaya_neem_400',
                name: 'Himalaya Herbals Purifying Neem Face Wash | For Acne & Pimple Relief | Paraben and Soap Free Face Care Product | Turmeric',
                packSize: '400 ml Face Wash',
                rating: 4.5,
                ratingCount: 1030,
                imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=600&q=80',
                price: 557,
                mrp: 599,
                discountPercent: 7,
                deliveryEta: 'Get by Thu, 24 Sep',
                category: 'skin_care',
              ));

    _recScrollController.addListener(() {
      if (_recScrollController.hasClients &&
          _recScrollController.position.maxScrollExtent > 0) {
        setState(() {
          _recScrollProgress = (_recScrollController.position.pixels /
                  _recScrollController.position.maxScrollExtent)
              .clamp(0.0, 1.0);
        });
      }
    });
  }

  @override
  void dispose() {
    _recScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.to;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded, color: Color(0xFF0F172A)),
          ),
          IconButton(
            onPressed: () {
              Get.snackbar(
                'Share Product',
                'Product link copied to clipboard.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.textPrimary,
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
              );
            },
            icon: const Icon(Icons.share_outlined, color: Color(0xFF0F172A)),
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
          ListView(
            padding: const EdgeInsets.only(bottom: 120),
            children: [
              // 1. Hero Product Image with Badges
              _buildHeroImageSection(),

              // 2. Title & Pricing
              _buildTitleAndPrice(),

              // 3. Size & Variant Selectors
              _buildSizeVariantSelector(),

              // 4. Delivery ETA box & Quick Add Row
              _buildDeliveryAndQuickAdd(cartController),

              // 5. Authentically Organic Banner
              _buildOrganicBanner(),

              // 6. Sponsored Organic India Virgin Coconut Oil Card
              _buildSponsoredCard(cartController),

              // 7. Pill Tabs: Product Information / Ratings and Reviews
              _buildNavigationTabs(),

              // 8. Frequently bought together
              _buildFrequentlyBoughtTogether(cartController),

              // 9. Cuticolor Hair Color Banner
              _buildCuticolorBanner(),

              // 10. "Also check these out" Recommended section
              _buildRecommendedSection(),

              // 11. Product Information Section
              _buildProductInformationSection(),

              // 12. Payment, Returns & Expiry (Screenshot 2)
              _buildPaymentReturnsExpirySection(),

              // 13. 4 Feature Badges (Screenshot 2)
              _buildFeatureBadges(),

              // 14. Stomach health story survey (Screenshot 2)
              _buildStomachHealthSurvey(),

              // 15. Other information (Screenshot 3)
              _buildOtherInformationSection(),

              // 16. Ratings and Reviews Breakdown
              _buildRatingsAndReviewsSection(),
            ],
          ),

          // Bottom Floating Coupon Bar & Sticky CTA Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomStickyBar(cartController),
          ),
        ],
      ),
    );
  }

  void _showRecommendedAddOnsModal(BuildContext context, CartController cartController) {
    final addOns = [
      {'name': 'Himalaya Men Pimple Clear Neem Face Wash', 'pack': '100 ml Face Wash', 'rating': '4.1', 'count': '335', 'price': '183', 'mrp': '189', 'off': '3%', 'img': 'https://images.unsplash.com/photo-1621607512214-68297480165e?auto=format&fit=crop&w=300&q=80'},
      {'name': 'Himalaya Natural Glow Kesar Face Wash', 'pack': '50 ml Face Wash', 'rating': '4.0', 'count': '39', 'price': '87.2', 'mrp': '90', 'off': '3%', 'chip': '78.5', 'img': 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80'},
      {'name': 'Himalaya Tan Removal Orange Face Wash', 'pack': '100 ml Face Wash', 'rating': '4.2', 'count': '712', 'price': '220', 'off': '10%', 'chip': '198', 'img': 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=300&q=80'},
      {'name': 'Dettol Original Germ Protection Mega Saver Pack of Bathing Soap Bar', 'pack': '4 Packs', 'rating': '4.3', 'count': '186', 'price': '160', 'mrp': '180', 'off': '11%', 'img': 'https://images.unsplash.com/photo-1603398938378-e54eab446dde?auto=format&fit=crop&w=300&q=80'},
    ];

    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.82,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recommended for you',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    customBorder: const CircleBorder(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Color(0xFFF1F5F9), shape: BoxShape.circle),
                      child: const Icon(Icons.close, size: 18, color: Color(0xFF0F172A)),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: addOns.length,
                separatorBuilder: (context, index) => const Divider(height: 24),
                itemBuilder: (context, index) {
                  final item = addOns[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 75,
                        height: 95,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: item['img']!,
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) => const Icon(Icons.spa, color: Colors.green),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name']!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                            ),
                            const SizedBox(height: 2),
                            Text(item['pack']!, style: const TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(color: const Color(0xFF16A34A), borderRadius: BorderRadius.circular(3)),
                                  child: Row(
                                    children: [
                                      Text(item['rating']!, style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold)),
                                      const SizedBox(width: 2),
                                      const Icon(Icons.star, size: 9, color: Colors.white),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text('${item['count']} ratings', style: const TextStyle(fontSize: 9.5, color: Color(0xFF94A3B8))),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('₹${item['price']}', style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 85,
                              height: 30,
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.snackbar(
                                    'Added to Cart',
                                    '${item['name']} added.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: AppColors.textPrimary,
                                    colorText: Colors.white,
                                    margin: const EdgeInsets.all(16),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: const BorderSide(color: AppColors.primary),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                ),
                                child: const Text('ADD', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.toNamed(AppRoutes.cart);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF523B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text('Skip & continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildPaymentReturnsExpirySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF9FE), // Soft lavender tint
        borderRadius: AppDimensions.rounded16,
        border: Border.all(color: const Color(0xFFF3E8FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment, Returns & Expiry',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF6B21A8)),
          ),
          const SizedBox(height: 14),
          _buildInfoItem(
            icon: Icons.payments_outlined,
            iconColor: const Color(0xFF16A34A),
            title: 'Cash on delivery available',
            sub: 'Get your product first, then pay us once you\'re sure about your order',
          ),
          const SizedBox(height: 14),
          _buildInfoItem(
            icon: Icons.replay_circle_filled_rounded,
            iconColor: const Color(0xFF0D9488),
            title: '7 day free return',
            sub: 'Easily return the product if you don\'t need it anymore',
          ),
          const SizedBox(height: 14),
          _buildInfoItem(
            icon: Icons.calendar_month_rounded,
            iconColor: const Color(0xFF2563EB),
            title: 'Product expires after Apr, 2028',
            sub: 'Expiry date may vary by batch. All batches have a 3-month shelf life from the date of dispatch.',
          ),
          const SizedBox(height: 14),
          _buildInfoItem(
            icon: Icons.receipt_long_rounded,
            iconColor: const Color(0xFF059669),
            title: 'Price Info',
            sub: 'MRP may vary by batch. Any additional charges, including packaging, handling, shipping or delivery charges, will be clearly disclosed before purchase.',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({required IconData icon, required Color iconColor, required String title, required String sub}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
              const SizedBox(height: 2),
              Text(sub, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureBadges() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildMiniBadge(Icons.inventory_2_outlined, const Color(0xFF16A34A), '100%\ngenuine\nproducts'),
          const SizedBox(width: 8),
          _buildMiniBadge(Icons.account_balance_wallet_outlined, const Color(0xFF2563EB), 'Safe &\nsecure\npayments'),
          const SizedBox(width: 8),
          _buildMiniBadge(Icons.markunread_mailbox_outlined, const Color(0xFFEA580C), 'No contact\ndelivery'),
          const SizedBox(width: 8),
          _buildMiniBadge(Icons.sanitizer_outlined, const Color(0xFF0284C7), 'Fully\nsanitized\nfacilities'),
        ],
      ),
    );
  }

  Widget _buildMiniBadge(IconData icon, Color color, String label) {
    return Expanded(
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 20),
            Text(label, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: Color(0xFF334155), height: 1.15)),
          ],
        ),
      ),
    );
  }

  Widget _buildStomachHealthSurvey() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBAE6FD)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Color(0xFF0284C7), shape: BoxShape.circle),
            child: const Icon(Icons.help_outline_rounded, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Share your stomach health story', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                SizedBox(height: 2),
                Text('Take this 2 minutes survey to share how you manage stomach health. Your insights help us serve you better', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFFFF523B), borderRadius: BorderRadius.circular(6)),
            child: const Text('Next', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherInformationSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Other information', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
              Icon(Icons.chevron_right_rounded, color: Color(0xFF64748B)),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'A licensed vendor partner from your nearest location will deliver Himalaya Herbals Purifying Neem Face Wash | For Acne & Pimple Relief | Paraben and Soap Free Face Care Product | Turmeric. Once the pharmacy accepts your order, the details of the pharmacy will be shared with you.',
            style: TextStyle(fontSize: 11.5, color: Color(0xFF475569), height: 1.35),
          ),
          const SizedBox(height: 12),
          const Text('Marketer details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
          const Text('Name: Himalaya Wellness Company\nAddress: Makali, Bengaluru 562162, India\nCountry of origin: India', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.3)),
          const SizedBox(height: 12),
          const Text('In case of any issues, contact us', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
          const Text('Email ID: care@jeevancare.com\nPhone Number: 1800-266-4357\nAddress: Presidency Building, Station Road, Buxar', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.3)),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  Widget _buildHeroImageSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFCFCFD),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: Stack(
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: _activeProduct.imageUrl,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.spa_rounded,
                      size: 80,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ),

                // "59 people bought recently" tag on bottom-left
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.group_outlined, size: 14, color: Color(0xFF3B82F6)),
                        SizedBox(width: 4),
                        Text(
                          '59 people bought recently',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // "4.5 ★ | 1000+ ratings" Laurel wreath badge on bottom-right
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('🌿 ', style: TextStyle(fontSize: 12)),
                            Text(
                              '4.5 ★',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF16A34A),
                              ),
                            ),
                            Text(' 🌿', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '1000+ ratings',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 6,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAndPrice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _activeProduct.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          // "Check top deal >" Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF38BDF8), width: 1.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Check top deal',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0284C7),
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.chevron_right_rounded, size: 16, color: Color(0xFF0284C7)),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Price Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                Formatters.formatCurrency(_activeProduct.price),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                Formatters.formatCurrency(_activeProduct.mrp),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF94A3B8),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${_activeProduct.discountPercent}% off',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF16A34A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSizeVariantSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Size
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
              children: [
                const TextSpan(text: 'Size: ', style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: _sizes[_selectedSizeIndex], style: const TextStyle(color: Color(0xFF64748B))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: List.generate(_sizes.length, (index) {
              final isSel = _selectedSizeIndex == index;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedSizeIndex = index;
                  });
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSel ? const Color(0xFF0F172A) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSel ? const Color(0xFF0F172A) : const Color(0xFFCBD5E1),
                    ),
                  ),
                  child: Text(
                    _sizes[index],
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                      color: isSel ? Colors.white : const Color(0xFF334155),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 14),

          // Variant
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
              children: [
                TextSpan(text: 'Variant: ', style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: 'Turmeric', style: TextStyle(color: Color(0xFF64748B))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Turmeric',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAndQuickAdd(CartController cartController) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Column(
        children: [
          // Delivery Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppDimensions.rounded12,
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: const [
                Text(
                  'Delivery by ',
                  style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
                ),
                Text(
                  'Thursday, 24 September',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                ),
                SizedBox(width: 6),
                Icon(Icons.access_time_rounded, size: 15, color: Color(0xFF0F172A)),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Inline selection and ADD button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _sizes[_selectedSizeIndex],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
              SizedBox(
                width: 120,
                height: 38,
                child: ElevatedButton(
                  onPressed: () {
                    cartController.addToCart(_activeProduct);
                    showRecommendedAddOnsSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF523B), // Vibrant red-orange
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrganicBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFEBF5FB),
        borderRadius: AppDimensions.rounded16,
        border: Border.all(color: const Color(0xFFD6EAF8)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Authentically Organic,\nNot Just in Name',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF9A3412),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEA580C),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Upto 20% Off*',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            top: 10,
            bottom: 10,
            width: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=400&q=80',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSponsoredCard(CartController cartController) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDimensions.rounded12,
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ad badge on top
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: const Text(
                'Ad',
                style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 120,
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=400&q=80',
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => const Icon(Icons.spa, size: 50, color: Colors.green),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Organic India Cold Pressed Virgin Coconut Oil, Certified Organic',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 2),
          const Text('500 ml Oil', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.star, size: 12, color: Color(0xFF16A34A)),
              Icon(Icons.star, size: 12, color: Color(0xFF16A34A)),
              Icon(Icons.star, size: 12, color: Color(0xFF16A34A)),
              Icon(Icons.star, size: 12, color: Color(0xFF16A34A)),
              Icon(Icons.star_half, size: 12, color: Color(0xFF16A34A)),
              SizedBox(width: 4),
              Text('4.5', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF16A34A))),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text('₹743', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                      SizedBox(width: 6),
                      Text('₹799', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8), decoration: TextDecoration.lineThrough)),
                      SizedBox(width: 6),
                      Text('7% off', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF16A34A))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFBE123C), borderRadius: BorderRadius.circular(3)),
                    child: const Text('₹669 order for ₹1200', style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              SizedBox(
                height: 36,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF523B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  child: const Text('Shop now', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildTabPill('Product information', 0),
          const SizedBox(width: 8),
          _buildTabPill('Ratings and Reviews', 1),
        ],
      ),
    );
  }

  Widget _buildTabPill(String title, int index) {
    final isSel = _selectedTabPill == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTabPill = index;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSel ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSel ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0)),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
            color: isSel ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildFrequentlyBoughtTogether(CartController cartController) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Frequently bought together',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 14),

          // Item 1
          Row(
            children: [
              Container(
                width: 70,
                height: 90,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: CachedNetworkImage(
                  imageUrl: _activeProduct.imageUrl,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const Icon(Icons.spa),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Himalaya Herbals Purifying Neem Face Wash | For Acne & Pimple Reli...',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                    ),
                    SizedBox(height: 2),
                    Text('400 ml Face Wash', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
                    SizedBox(height: 4),
                    Text('₹557', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                  ],
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(child: Icon(Icons.add, color: Color(0xFF0F172A), size: 24)),
          ),

          // Item 2: Plum Green Tea
          Row(
            children: [
              Container(
                width: 70,
                height: 90,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: CachedNetworkImage(
                  imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80',
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const Icon(Icons.spa),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Plum Green Tea Pore Cleansing Face Wash',
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                    ),
                    SizedBox(height: 2),
                    Text('50 ml Face Wash', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
                    SizedBox(height: 4),
                    Text('₹179', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCuticolorBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 135,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: AppDimensions.rounded16,
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '100%\nGrey Coverage.\nZero\nCompromise.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), height: 1.1),
                ),
                SizedBox(height: 6),
                Text(
                  'BACKED BY KOREAN SCIENCE',
                  style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w700, color: Color(0xFF0284C7)),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 140,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection() {
    final recItems = [
      {'title': 'Purifying Neem Face Wash | Clears and Prevents Pimples', 'pack': '50 ml Face Wash', 'price': '89', 'mrp': '90', 'chip': '80.1', 'img': 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80'},
      {'title': 'Himalaya Herbals Purifying Neem Face Wash | For Acne & Pi...', 'pack': '150 ml Face Wash', 'price': '271', 'mrp': '279', 'chip': '244', 'img': 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80'},
      {'title': 'Purifying Neem Face Wash | Clears Pores', 'pack': '200 ml Face Wash', 'price': '422', 'mrp': '450', 'chip': '380', 'img': 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Also check these out',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                    ),
                    Text('Recommended for you', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(color: Color(0xFFF3E8FF), shape: BoxShape.circle),
                  child: const Icon(Icons.medication_rounded, color: Color(0xFF9333EA), size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Filter pills
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildRecPill('Similar Products', 0),
                const SizedBox(width: 8),
                _buildRecPill('Handpicked for You', 1),
                const SizedBox(width: 8),
                _buildRecPill('Top Picks', 2),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Horizontal list
          SizedBox(
            height: 290,
            child: ListView.separated(
              controller: _recScrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: recItems.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = recItems[index];
                return Container(
                  width: 155,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 100,
                          child: CachedNetworkImage(
                            imageUrl: item['img']!,
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) => const Icon(Icons.spa, color: Colors.green),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(item['title']!, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF0F172A), height: 1.2)),
                      const SizedBox(height: 2),
                      Text(item['pack']!, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      const SizedBox(height: 4),
                      Text('₹${item['price']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
                        decoration: BoxDecoration(color: const Color(0xFFBE123C), borderRadius: BorderRadius.circular(2)),
                        child: Text('₹${item['chip']} order for ₹1200', style: const TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w700)),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 28,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          child: const Text('ADD', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),

          // Scroll indicator
          Center(
            child: Container(
              width: 100,
              height: 3,
              decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(2)),
              child: Stack(
                children: [
                  Positioned(
                    left: _recScrollProgress * 65,
                    child: Container(width: 35, height: 3, decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(2))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecPill(String label, int index) {
    final isSel = _selectedRecCategory == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedRecCategory = index;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSel ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSel ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: isSel ? FontWeight.w700 : FontWeight.w500, color: isSel ? Colors.white : const Color(0xFF64748B)),
        ),
      ),
    );
  }

  Widget _buildProductInformationSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Product information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
          const SizedBox(height: 8),
          Text(
            'Himalaya Herbals Purifying Neem Face Wash with Turmeric is a soap-free herbal formulation designed to gently cleanse the skin and remove impurities. Enriched with neem and turmeric extracts, it helps purify the skin and support overall skin health. The gentle pH-skin friendly formula prevents acne without drying out the skin.',
            maxLines: _isExpandedDescription ? null : 3,
            overflow: _isExpandedDescription ? null : TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Color(0xFF475569), height: 1.4),
          ),
          const SizedBox(height: 6),
          Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  _isExpandedDescription = !_isExpandedDescription;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_isExpandedDescription ? 'See less' : 'See more', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                  Icon(_isExpandedDescription ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 16, color: const Color(0xFF0F172A)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingsAndReviewsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ratings and reviews', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
          const SizedBox(height: 14),

          // Rating banner
          Row(
            children: const [
              Text('🌿 ', style: TextStyle(fontSize: 18)),
              Text('4.5 stars', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              Text(' 🌿', style: TextStyle(fontSize: 18)),
              Spacer(),
              Icon(Icons.star, color: Color(0xFF16A34A), size: 20),
              Icon(Icons.star, color: Color(0xFF16A34A), size: 20),
              Icon(Icons.star, color: Color(0xFF16A34A), size: 20),
              Icon(Icons.star, color: Color(0xFF16A34A), size: 20),
              Icon(Icons.star_half, color: Color(0xFF16A34A), size: 20),
            ],
          ),
          const Divider(height: 24),

          // Breakdown
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildRatingBar(5, 71),
                    _buildRatingBar(4, 20),
                    _buildRatingBar(3, 4),
                    _buildRatingBar(2, 1),
                    _buildRatingBar(1, 4),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('1030 ratings & 188 reviews', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    SizedBox(height: 4),
                    Text('913 customers have rated this product as 4 stars and above', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B), height: 1.3)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Review Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nice product for your daily routine ,...................', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(color: Color(0xFFFCE7F3), shape: BoxShape.circle),
                      child: const Center(child: Text('P', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFFBE185D)))),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Pradip Mondal', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                        Text('February, 2024', style: TextStyle(fontSize: 9.5, color: Color(0xFF94A3B8))),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: const [
                        Icon(Icons.star, size: 12, color: Color(0xFF16A34A)),
                        Icon(Icons.star, size: 12, color: Color(0xFF16A34A)),
                        Icon(Icons.star, size: 12, color: Color(0xFF16A34A)),
                        Icon(Icons.star, size: 12, color: Color(0xFF16A34A)),
                        Icon(Icons.star, size: 12, color: Color(0xFF16A34A)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // "See all 188 reviews" button
          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFEA580C),
                side: const BorderSide(color: Color(0xFFEA580C)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('See all 188 reviews', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, int pct) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$stars', style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
          const SizedBox(width: 4),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(2)),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: pct / 100.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: stars >= 4 ? const Color(0xFF16A34A) : (stars == 3 ? const Color(0xFFEAB308) : const Color(0xFFDC2626)),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text('$pct%', style: const TextStyle(fontSize: 9, color: Color(0xFF64748B))),
        ],
      ),
    );
  }

  Widget _buildBottomStickyBar(CartController cartController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Coupon Strip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xFF881337), // Dark plum
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.keyboard_arrow_up, size: 12, color: Color(0xFF881337)),
              ),
              const SizedBox(width: 6),
              const Text('Apply coupon to get ', style: TextStyle(color: Colors.white, fontSize: 11)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(2)),
                child: const Text('EXTRA 10% OFF', style: TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w900)),
              ),
              const Text(' on health products', style: TextStyle(color: Colors.white, fontSize: 11)),
            ],
          ),
        ),

        // Sticky Price and Red ADD Button
        Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        Formatters.formatCurrency(_activeProduct.price),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        Formatters.formatCurrency(_activeProduct.mrp),
                        style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8), decoration: TextDecoration.lineThrough),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${_activeProduct.discountPercent}% off',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF16A34A)),
                      ),
                    ],
                  ),
                ],
              ),
              Obx(() {
                final qty = cartController.getQuantity(_activeProduct.id);
                if (qty == 0) {
                  return SizedBox(
                    width: 140,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        cartController.addToCart(_activeProduct);
                        showRecommendedAddOnsSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF523B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: const Text('ADD', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white)),
                    ),
                  );
                } else {
                  return Container(
                    width: 140,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF523B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => cartController.decrementQuantity(_activeProduct.id),
                          icon: const Icon(Icons.remove, color: Colors.white, size: 18),
                        ),
                        Text(
                          '$qty',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        IconButton(
                          onPressed: () => cartController.addToCart(_activeProduct),
                          icon: const Icon(Icons.add, color: Colors.white, size: 18),
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
