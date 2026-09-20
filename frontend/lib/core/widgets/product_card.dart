import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimensions.dart';
import '../../app/theme/app_typography.dart';
import '../../data/models/product_model.dart';
import '../../modules/cart/controllers/cart_controller.dart';
import '../utils/formatters.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final double width;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.width = 175,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.to;

    return InkWell(
      onTap: onTap,
      borderRadius: AppDimensions.rounded12,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppDimensions.rounded12,
          border: Border.all(color: AppColors.borderLight, width: 1),
          boxShadow: AppDimensions.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with floating rating badge
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppDimensions.space8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFCFCFD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.radius12),
                      topRight: Radius.circular(AppDimensions.radius12),
                    ),
                  ),
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.medication_liquid_rounded,
                        size: 48,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
                // Rating Badge
                Positioned(
                  left: 8,
                  bottom: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.ratingGreen,
                      borderRadius: AppDimensions.rounded4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.star_rounded,
                          size: 11,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                if (product.isBestSeller)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.badgeOrangeBg,
                        borderRadius: AppDimensions.rounded4,
                        border: Border.all(color: AppColors.badgeOrange.withValues(alpha: 0.3)),
                      ),
                      child: const Text(
                        'BESTSELLER',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppColors.badgeOrange,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  SizedBox(
                    height: 36,
                    child: Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.subtitle.copyWith(
                        fontSize: 12.5,
                        height: 1.25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Pack size
                  Text(
                    product.packSize,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 3),

                  // Delivery ETA
                  Text(
                    product.deliveryEta,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 10.5,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Price & Discount Row
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 5,
                    runSpacing: 2,
                    children: [
                      Text(
                        Formatters.formatCurrency(product.price),
                        style: AppTypography.priceBold.copyWith(fontSize: 13.5),
                      ),
                      Text(
                        Formatters.formatCurrency(product.mrp),
                        style: AppTypography.priceStrikethrough.copyWith(fontSize: 11),
                      ),
                      Text(
                        '${product.discountPercent}% off',
                        style: AppTypography.discountText.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Care Plan row if available
                  if (product.carePlanPrice != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.carePlanBg,
                        borderRadius: AppDimensions.rounded4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.carePlanPurple,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              Formatters.formatCurrency(product.carePlanPrice!),
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              'order for ${Formatters.formatCurrency(product.carePlanThreshold ?? 1200)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 9.5,
                                color: AppColors.carePlanPurple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    const SizedBox(height: 24),

                  // Reactive Add to Cart / Quantity Controller
                  Obx(() {
                    final qty = cartController.getQuantity(product.id);
                    if (qty == 0) {
                      return SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: OutlinedButton(
                          onPressed: () => cartController.addToCart(product),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary, width: 1.2),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppDimensions.rounded6,
                            ),
                          ),
                          child: const Text(
                            'ADD',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: AppDimensions.rounded6,
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
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
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
        ),
      ),
    );
  }
}
