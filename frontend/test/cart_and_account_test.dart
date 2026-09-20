import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:jeevancare/modules/cart/controllers/cart_controller.dart';
import 'package:jeevancare/modules/cart/screens/cart_screen.dart';
import 'package:jeevancare/modules/cart/widgets/care_plan_upsell_sheet.dart';
import 'package:jeevancare/modules/profile/screens/profile_screen.dart';
import 'package:jeevancare/modules/pharmacy/screens/upload_prescription_screen.dart';
import 'package:jeevancare/core/widgets/sign_in_sheet.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    if (!Get.isRegistered<CartController>()) {
      Get.put(CartController());
    }
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('CartScreen renders delivery pill, item, care plan card, and before checkout', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: CartScreen(),
      ),
    );
    await tester.pump();

    // Verify Delivery Promise Pill
    expect(find.text('Delivering by 24 - 26 september'), findsOneWidget);

    // Verify Care Plan card
    expect(find.text('Care Plan'), findsAtLeastNWidgets(1));
    expect(find.text('Extra 4% off '), findsOneWidget);
    expect(find.text('on all products'), findsOneWidget);

    // Verify "Before you checkout"
    expect(find.text('Before you checkout'), findsOneWidget);
    expect(find.text('In the spotlight'), findsOneWidget);
    expect(find.text('Last Minute Buys'), findsOneWidget);

    // Verify sticky bottom button
    expect(find.text('Login to continue'), findsOneWidget);
  });

  testWidgets('ProfileScreen renders Hi there, Sign in, and full services list', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: ProfileScreen(),
      ),
    );
    await tester.pump();

    expect(find.text('Hi there!'), findsOneWidget);
    expect(find.text('Sign in to start your healthcare journey'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('My orders'), findsOneWidget);
    expect(find.text('My lab tests'), findsOneWidget);
    expect(find.text('Scan your medicines'), findsOneWidget);
    expect(find.text('Understandable, Accessible & Affordable'), findsOneWidget);
  });

  testWidgets('UploadPrescriptionScreen renders illustration and upload action', (tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: UploadPrescriptionScreen(),
      ),
    );
    await tester.pump();

    expect(find.text('Upload prescriptions'), findsOneWidget);
    expect(find.text('and let us arrange your medicines for you'), findsOneWidget);
    expect(find.text('Upload prescription'), findsOneWidget);
    expect(find.text('What is a valid prescription?'), findsOneWidget);
  });

  testWidgets('CarePlanUpsellSheet renders savings headline and Add Care Plan button', (tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: CarePlanUpsellSheet(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('W  I  T  H'), findsOneWidget);
    expect(find.text('Care Plan'), findsOneWidget);
    expect(find.text('Free delivery'), findsOneWidget);
    expect(find.text('Add Care Plan'), findsOneWidget);
    expect(find.text("I'm not interested"), findsOneWidget);
  });

  testWidgets('SignInBottomSheet renders phone input and verification action', (tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: SignInBottomSheet(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Sign in to continue'), findsOneWidget);
    expect(find.text('+91'), findsOneWidget);
    expect(find.text('Get verification code'), findsOneWidget);
    expect(find.text('Sign in with email'), findsOneWidget);
  });
}
