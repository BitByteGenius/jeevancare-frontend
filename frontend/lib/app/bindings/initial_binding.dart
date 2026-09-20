import 'package:get/get.dart';
import '../../data/repositories/home_repository.dart';
import '../../data/repositories/mock_home_repository.dart';
import '../../modules/cart/controllers/cart_controller.dart';
import '../../modules/pharmacy/controllers/pharmacy_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core repositories
    Get.lazyPut<HomeRepository>(() => MockHomeRepository(), fenix: true);

    // Global persistent controllers
    Get.put<CartController>(CartController(), permanent: true);
    Get.lazyPut<PharmacyController>(() => PharmacyController(), fenix: true);
  }
}

