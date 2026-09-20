import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:jeevancare/core/widgets/product_card.dart';
import 'package:jeevancare/data/models/product_model.dart';
import 'package:jeevancare/modules/cart/controllers/cart_controller.dart';

void main() {
  testWidgets('ProductCard renders name, price, and responds to ADD click', (WidgetTester tester) async {
    Get.put(CartController());

    const product = ProductModel(
      id: 'test_1',
      name: 'Nivea Lip Balm Strawberry Shine',
      packSize: '4.8 gm Balm',
      rating: 4.5,
      imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03',
      price: 204,
      mrp: 240,
      discountPercent: 15,
      deliveryEta: 'Get by Thu, 24 Sep',
      category: 'skin_care',
    );

    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: ProductCard(product: product),
        ),
      ),
    );

    expect(find.text('Nivea Lip Balm Strawberry Shine'), findsOneWidget);
    expect(find.text('4.8 gm Balm'), findsOneWidget);
    expect(find.text('ADD'), findsOneWidget);

    // Tap ADD
    await tester.tap(find.text('ADD'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));

    // Verify quantity changes to 1
    expect(find.text('1'), findsOneWidget);
    expect(CartController.to.totalItemCount, 1);
  });
}
