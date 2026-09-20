import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/routes/app_routes.dart';
import '../../cart/controllers/cart_controller.dart';
import '../data/pharmacy_data.dart';
import 'category_products_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedGroupIndex = 0;
  final ScrollController _rightContentController = ScrollController();

  @override
  void dispose() {
    _rightContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.to;
    final groups = PharmacyData.categoryGroups;
    final activeGroup = groups[_selectedGroupIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2E1744), // Deep royal plum
                Color(0xFF1E0C30),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // Back Button
                  InkWell(
                    onTap: () => Get.back(),
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Title
                  const Expanded(
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  // Cart Button
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.cart),
                    customBorder: const CircleBorder(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 19),
                        ),
                        Obx(() {
                          final count = cartController.totalItemCount;
                          if (count == 0) return const SizedBox.shrink();
                          return Positioned(
                            right: -2,
                            top: -2,
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
                ],
              ),
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          // Left Rail (Category list)
          Container(
            width: 88,
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              border: Border(
                right: BorderSide(color: Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                final isSelected = _selectedGroupIndex == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedGroupIndex = index;
                    });
                    if (_rightContentController.hasClients) {
                      _rightContentController.jumpTo(0);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      border: Border(
                        right: BorderSide(
                          color: isSelected ? const Color(0xFF9E1A5F) : Colors.transparent, // Crimson/magenta active bar
                          width: 3.5,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFFCE7F3) : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected ? const Color(0xFFF472B6) : const Color(0xFFE2E8F0),
                              width: 0.8,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: group.iconUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(
                                Icons.category_rounded,
                                size: 22,
                                color: Color(0xFF9E1A5F),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          group.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                            height: 1.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Right Content Area (Subcategories 3-column Grid)
          Expanded(
            child: ListView(
              controller: _rightContentController,
              padding: const EdgeInsets.fromLTRB(14, 16, 14, 24),
              children: [
                // Active Section Header
                Text(
                  activeGroup.name.replaceAll('\n', ' '),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 14),

                // 3-Column Grid of Subcategories
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: activeGroup.subcategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final sub = activeGroup.subcategories[index];
                    return InkWell(
                      onTap: () {
                        Get.to(() => CategoryProductsScreen(categoryTitle: sub.title.replaceAll('\n', ' ')));
                      },
                      borderRadius: AppDimensions.rounded12,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 72,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF0EC), // Soft peach matching screenshot
                              borderRadius: AppDimensions.rounded12,
                              border: Border.all(color: const Color(0xFFFFDDD2)),
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: CachedNetworkImage(
                                  imageUrl: sub.imageUrl,
                                  fit: BoxFit.contain,
                                  errorWidget: (context, url, error) => const Icon(
                                    Icons.medication_liquid_rounded,
                                    size: 32,
                                    color: Color(0xFFEA580C),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Text(
                              sub.title,
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

                const SizedBox(height: 20),

                // Wavy Line Separator
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 12,
                    child: CustomPaint(
                      painter: _WavyLinePainter(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Next Category Preview Section
                if (_selectedGroupIndex + 1 < groups.length) ...[
                  Text(
                    groups[_selectedGroupIndex + 1].name.replaceAll('\n', ' '),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 14),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: groups[_selectedGroupIndex + 1].subcategories.take(3).length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final sub = groups[_selectedGroupIndex + 1].subcategories[index];
                      return InkWell(
                        onTap: () {
                          Get.to(() => CategoryProductsScreen(categoryTitle: sub.title.replaceAll('\n', ' ')));
                        },
                        borderRadius: AppDimensions.rounded12,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 72,
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF0EC),
                                borderRadius: AppDimensions.rounded12,
                                border: Border.all(color: const Color(0xFFFFDDD2)),
                              ),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: CachedNetworkImage(
                                    imageUrl: sub.imageUrl,
                                    fit: BoxFit.contain,
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.medication_rounded,
                                      size: 32,
                                      color: Color(0xFFEA580C),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Expanded(
                              child: Text(
                                sub.title,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WavyLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height / 2);

    const waveWidth = 16.0;
    const waveHeight = 4.0;
    for (double x = 0; x < size.width; x += waveWidth) {
      path.relativeQuadraticBezierTo(
        waveWidth / 4,
        -waveHeight,
        waveWidth / 2,
        0,
      );
      path.relativeQuadraticBezierTo(
        waveWidth / 4,
        waveHeight,
        waveWidth / 2,
        0,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
