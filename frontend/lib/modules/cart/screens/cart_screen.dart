import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.to;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
        actions: [
          Obx(() {
            if (controller.items.isEmpty) return const SizedBox.shrink();
            return TextButton(
              onPressed: () => controller.clearCart(),
              child: const Text('Clear', style: TextStyle(color: AppColors.badgeRed)),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Your cart is empty',
                  style: AppTypography.headline2.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore products and add items to your cart',
                  style: AppTypography.caption.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDimensions.roundedFull,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Start Shopping', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          );
        }

        final items = controller.items.values.toList();

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Care Plan banner in Cart
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.carePlanBg,
                      borderRadius: AppDimensions.rounded12,
                      border: Border.all(color: AppColors.carePlanPurple.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star_rounded, color: AppColors.carePlanPurple),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Save extra on medicines & lab tests with JeevanCare Plan membership!',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.carePlanPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Cart Item Cards
                  ...items.map((cartItem) {
                    final p = cartItem.product;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppDimensions.rounded12,
                        border: Border.all(color: AppColors.borderLight),
                        boxShadow: AppDimensions.subtleShadow,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: AppDimensions.rounded8,
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: CachedNetworkImage(
                                imageUrl: p.imageUrl,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.medication_liquid_rounded,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.subtitle.copyWith(fontSize: 13),
                                ),
                                const SizedBox(height: 2),
                                Text(p.packSize, style: AppTypography.caption),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      Formatters.formatCurrency(p.price),
                                      style: AppTypography.priceBold.copyWith(fontSize: 14),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      Formatters.formatCurrency(p.mrp),
                                      style: AppTypography.priceStrikethrough.copyWith(fontSize: 11),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Quantity Selector
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: AppDimensions.rounded6,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 14, color: AppColors.primary),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                                  onPressed: () => controller.decrementQuantity(p.id),
                                ),
                                Text(
                                  '${cartItem.quantity}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: AppColors.primary,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 14, color: AppColors.primary),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                                  onPressed: () => controller.addToCart(p),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 12),

                  // Bill Details Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppDimensions.rounded12,
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bill Summary', style: AppTypography.subtitle),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Item Total (MRP)', style: AppTypography.bodyRegular),
                            Text(Formatters.formatCurrency(controller.totalMrp), style: AppTypography.bodyMedium),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Price Discount', style: AppTypography.bodyRegular),
                            Text('- ${Formatters.formatCurrency(controller.totalSavings)}', style: AppTypography.discountText),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery Fee', style: AppTypography.bodyRegular),
                            const Text('FREE', style: TextStyle(color: AppColors.ratingGreen, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('To Pay', style: AppTypography.headline2.copyWith(fontSize: 15)),
                            Text(
                              Formatters.formatCurrency(controller.subtotal),
                              style: AppTypography.headline2.copyWith(fontSize: 16, color: AppColors.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Checkout Bottom Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: AppDimensions.elevatedShadow,
                border: const Border(top: BorderSide(color: AppColors.borderLight)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Total Amount', style: AppTypography.caption),
                      Text(
                        Formatters.formatCurrency(controller.subtotal),
                        style: AppTypography.headline2.copyWith(fontSize: 17, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Get.rawSnackbar(
                        messageText: const Text(
                          'Checkout process ready for backend integration!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: AppColors.primary,
                        borderRadius: 8,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: AppDimensions.roundedFull),
                    ),
                    child: const Text('Proceed to Pay', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
