import 'dart:async';
import 'package:get/get.dart';
import '../../../data/models/banner_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/quick_action_model.dart';
import '../../../data/models/service_tab_model.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../app/constants/app_constants.dart';

class HomeController extends GetxController {
  final HomeRepository _repository = Get.find<HomeRepository>();

  final RxBool isLoading = true.obs;
  final RxString selectedServiceTab = 'for_you'.obs;
  final RxInt currentBannerIndex = 0.obs;
  final RxInt searchHintIndex = 0.obs;

  final RxString selectedCity = AppConstants.defaultCity.obs;
  final RxString selectedLocality = AppConstants.defaultLocality.obs;

  final RxList<ServiceTabModel> serviceTabs = <ServiceTabModel>[].obs;
  final RxList<QuickActionModel> quickActions = <QuickActionModel>[].obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final RxList<CategoryModel> popularCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> healthyFoods = <CategoryModel>[].obs;

  // Category product lists
  final RxList<ProductModel> proteinSupplements = <ProductModel>[].obs;
  final RxList<ProductModel> intimateHygiene = <ProductModel>[].obs;
  final RxList<ProductModel> hormonalSupport = <ProductModel>[].obs;
  final RxList<ProductModel> menstrualCare = <ProductModel>[].obs;

  Timer? _searchHintTimer;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
    _startSearchHintTimer();
  }

  @override
  void onClose() {
    _searchHintTimer?.cancel();
    super.onClose();
  }

  void _startSearchHintTimer() {
    _searchHintTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (AppConstants.searchPlaceholders.isNotEmpty) {
        searchHintIndex.value = (searchHintIndex.value + 1) % AppConstants.searchPlaceholders.length;
      }
    });
  }

  Future<void> loadHomeData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        _repository.getServiceTabs(),
        _repository.getQuickActions(),
        _repository.getPromotionalBanners(),
        _repository.getPopularCategories(),
        _repository.getHealthyFoods(),
        _repository.getProductsByCategory('protein_supplements'),
        _repository.getProductsByCategory('intimate_hygiene'),
        _repository.getProductsByCategory('hormonal_support'),
        _repository.getProductsByCategory('menstrual_care'),
      ]);

      serviceTabs.assignAll(results[0] as List<ServiceTabModel>);
      quickActions.assignAll(results[1] as List<QuickActionModel>);
      banners.assignAll(results[2] as List<BannerModel>);
      popularCategories.assignAll(results[3] as List<CategoryModel>);
      healthyFoods.assignAll(results[4] as List<CategoryModel>);
      proteinSupplements.assignAll(results[5] as List<ProductModel>);
      intimateHygiene.assignAll(results[6] as List<ProductModel>);
      hormonalSupport.assignAll(results[7] as List<ProductModel>);
      menstrualCare.assignAll(results[8] as List<ProductModel>);
    } catch (e) {
      // Data load failure fallback
    } finally {
      isLoading.value = false;
    }
  }

  void selectServiceTab(String tabId) {
    selectedServiceTab.value = tabId;
  }

  void updateBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  void setCity(String city, String locality) {
    selectedCity.value = city;
    selectedLocality.value = locality;
  }
}
