import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/banner_model.dart';
import '../models/service_tab_model.dart';
import '../models/quick_action_model.dart';

abstract class HomeRepository {
  Future<List<ServiceTabModel>> getServiceTabs();
  Future<List<QuickActionModel>> getQuickActions();
  Future<List<BannerModel>> getPromotionalBanners();
  Future<List<CategoryModel>> getPopularCategories();
  Future<List<CategoryModel>> getHealthyFoods();
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<List<ProductModel>> searchProducts(String query);
}
