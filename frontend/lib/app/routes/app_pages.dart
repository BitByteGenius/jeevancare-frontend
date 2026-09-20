import 'package:get/get.dart';
import 'app_routes.dart';
import '../../modules/dashboard/bindings/dashboard_binding.dart';
import '../../modules/dashboard/screens/dashboard_screen.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/screens/home_screen.dart';
import '../../modules/cart/screens/cart_screen.dart';
import '../../modules/pharmacy/screens/pharmacy_screen.dart';
import '../../modules/lab_tests/screens/lab_tests_screen.dart';
import '../../modules/care_plan/screens/care_plan_screen.dart';
import '../../modules/profile/screens/profile_screen.dart';

import '../../modules/consults/screens/consults_screen.dart';
import '../../modules/pharmacy/screens/categories_screen.dart';
import '../../modules/pharmacy/screens/category_products_screen.dart';

class AppPages {
  static const initial = AppRoutes.dashboard;

  static final routes = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartScreen(),
    ),
    GetPage(
      name: AppRoutes.pharmacy,
      page: () => const PharmacyScreen(),
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => const CategoriesScreen(),
    ),
    GetPage(
      name: AppRoutes.categoryProducts,
      page: () => const CategoryProductsScreen(),
    ),
    GetPage(
      name: AppRoutes.consults,
      page: () => const ConsultsScreen(),
    ),
    GetPage(
      name: AppRoutes.labTests,
      page: () => const LabTestsScreen(),
    ),
    GetPage(
      name: AppRoutes.carePlan,
      page: () => const CarePlanScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
    ),
  ];
}
