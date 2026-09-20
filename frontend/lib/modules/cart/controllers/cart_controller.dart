import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../data/models/product_model.dart';
import '../../../app/theme/app_colors.dart';

class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();

  final RxMap<String, CartItemModel> _items = <String, CartItemModel>{}.obs;
  final RxBool isCarePlanActive = false.obs;
  final RxString selectedAddress = 'Buxar'.obs;
  final RxInt selectedDeliverySlot = 0.obs;

  Map<String, CartItemModel> get items => _items;

  void seedDefaultCartIfEmpty() {
    if (_items.isEmpty) {
      const defaultProduct = ProductModel(
        id: 'himalaya_neem_400',
        name: 'Himalaya Herbals Purifying Neem Face ...',
        packSize: '400 ml face wash',
        rating: 4.5,
        ratingCount: 1240,
        imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=400&q=80',
        price: 557,
        mrp: 599,
        discountPercent: 7,
        deliveryEta: 'Delivering by 24 - 26 september',
        carePlanPrice: 490,
        carePlanThreshold: 1200,
        category: 'skin_care',
      );
      _items[defaultProduct.id] = CartItemModel(product: defaultProduct, quantity: 1);
    }
  }

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
    if (isCarePlanActive.value) {
      total += 165.0; // 3 months care plan cost
    }
    return total;
  }

  double get totalMrp {
    double total = 0.0;
    for (final item in _items.values) {
      total += item.totalMrp;
    }
    if (isCarePlanActive.value) {
      total += 549.0;
    }
    return total;
  }

  double get totalSavings => totalMrp - subtotal + (isCarePlanActive.value ? 67.0 : 0.0);

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

  void setQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
    } else if (_items.containsKey(productId)) {
      _items[productId]!.quantity = quantity;
      _items.refresh();
    }
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

  void toggleCarePlan() {
    isCarePlanActive.value = !isCarePlanActive.value;
  }

  void addCarePlan() {
    isCarePlanActive.value = true;
    Get.rawSnackbar(
      messageText: const Text(
        'Care Plan added! Save extra ₹67 on this order',
        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF7A2326),
      duration: const Duration(seconds: 3),
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.verified_rounded, color: Colors.white, size: 20),
    );
  }
}

