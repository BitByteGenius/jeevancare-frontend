import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../data/models/product_model.dart';
import '../../../app/theme/app_colors.dart';

class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();

  final RxMap<String, CartItemModel> _items = <String, CartItemModel>{}.obs;

  Map<String, CartItemModel> get items => _items;

  int get totalItemCount {
    int count = 0;
    for (final item in _items.values) {
      count += item.quantity;
    }
    return count;
  }

  double get subtotal {
    double total = 0.0;
    for (final item in _items.values) {
      total += item.totalPrice;
    }
    return total;
  }

  double get totalMrp {
    double total = 0.0;
    for (final item in _items.values) {
      total += item.totalMrp;
    }
    return total;
  }

  double get totalSavings => totalMrp - subtotal;

  int getQuantity(String productId) {
    return _items[productId]?.quantity ?? 0;
  }

  void addToCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
      _items.refresh();
    } else {
      _items[product.id] = CartItemModel(product: product, quantity: 1);
    }
    Get.rawSnackbar(
      messageText: Text(
        'Added "${product.name.split(' ').take(3).join(' ')}..." to cart',
        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.textPrimary,
      duration: const Duration(seconds: 2),
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20),
    );
  }

  void decrementQuantity(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
      _items.refresh();
    } else {
      _items.remove(productId);
    }
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
  }

  void clearCart() {
    _items.clear();
  }
}
