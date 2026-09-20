import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:jeevancare/data/repositories/mock_home_repository.dart';
import 'package:jeevancare/data/repositories/home_repository.dart';
import 'package:jeevancare/modules/cart/controllers/cart_controller.dart';
import 'package:jeevancare/modules/home/controllers/home_controller.dart';
import 'package:jeevancare/modules/pharmacy/controllers/pharmacy_controller.dart';
import 'package:jeevancare/modules/pharmacy/screens/pharmacy_screen.dart';
import 'package:jeevancare/modules/consults/screens/consults_screen.dart';

void main() {
  setUp(() {
    Get.reset();
    Get.lazyPut<HomeRepository>(() => MockHomeRepository(), fenix: true);
    Get.put(CartController());
    Get.put(HomeController());
    Get.put(PharmacyController());
  });

  testWidgets('PharmacyScreen renders with all core sections and genuine hero banner', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);

    await Get.find<HomeController>().loadHomeData();

    await tester.pumpWidget(
      const GetMaterialApp(
        home: PharmacyScreen(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify Sticky location & Service Tab
    expect(find.text('Buxar'), findsOneWidget);
    expect(find.text('Pharmacy'), findsWidgets);

    // Verify Sawaal Uthao
    expect(find.text('Are my vegetables organic?'), findsOneWidget);
    expect(find.text('“Is my medicine genuine?”'), findsOneWidget);

    // Verify Quick Actions
    expect(find.text('Order with\nprescription'), findsOneWidget);
    expect(find.text('Call to order\nmedicines'), findsOneWidget);

    // Verify Popular categories
    expect(find.text('Popular categories'), findsOneWidget);
  });

  testWidgets('ConsultsScreen renders with doctor booking and symptom chips', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);

    await Get.find<HomeController>().loadHomeData();

    await tester.pumpWidget(
      const GetMaterialApp(
        home: ConsultsScreen(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Consults'), findsWidgets);
    expect(find.text('Consult now'), findsOneWidget);
    expect(find.text('Consult Doctor in 1 click'), findsOneWidget);
    expect(find.text('Why consult on JeevanCare?'), findsOneWidget);
    expect(find.text('Meet our doctors'), findsOneWidget);
  });
}
