import '../datasources/mock_home_data.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/banner_model.dart';
import '../models/service_tab_model.dart';
import '../models/quick_action_model.dart';
import 'home_repository.dart';

class MockHomeRepository implements HomeRepository {
  @override
  Future<List<ServiceTabModel>> getServiceTabs() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return MockHomeData.serviceTabs;
  }

  @override
  Future<List<QuickActionModel>> getQuickActions() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return MockHomeData.quickActions;
  }

  @override
  Future<List<BannerModel>> getPromotionalBanners() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return MockHomeData.banners;
  }

  @override
  Future<List<CategoryModel>> getPopularCategories() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return MockHomeData.popularCategories;
  }

  @override
  Future<List<CategoryModel>> getHealthyFoods() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return MockHomeData.healthyFoods;
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 50));
    switch (category) {
      case 'protein_supplements':
        return MockHomeData.proteinSupplements;
      case 'hormonal_support':
        return MockHomeData.hormonalSupport;
      case 'menstrual_care':
        return MockHomeData.menstrualCare;
      case 'intimate_hygiene':
        return MockHomeData.intimateHygiene;
      case 'skin_care':
        return MockHomeData.topSkinCare;
      case 'deals_of_the_day':
        return MockHomeData.dealsOfTheDay;
      case 'pet_care_deals':
        return MockHomeData.petCareDeals;
      default:
        return MockHomeData.proteinSupplements;
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final allProducts = [
      ...MockHomeData.proteinSupplements,
      ...MockHomeData.hormonalSupport,
      ...MockHomeData.menstrualCare,
      ...MockHomeData.intimateHygiene,
    ];
    if (query.trim().isEmpty) return allProducts;
    return allProducts
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
