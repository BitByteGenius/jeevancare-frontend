import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../controllers/home_controller.dart';
import '../widgets/location_header.dart';
import '../widgets/service_tab_bar.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/category_section.dart';
import '../widgets/featured_brands_section.dart';
import '../widgets/product_horizontal_list.dart';
import '../widgets/pet_care_section.dart';
import '../widgets/assessment_banner.dart';
import '../widgets/healthy_foods_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.loadHomeData(),
          color: AppColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // Sticky / Top Location & Header
              const SliverToBoxAdapter(
                child: LocationHeader(),
              ),

              // Service Tabs (For You, Pharmacy, Consults, Insurance, Vaccine)
              const SliverToBoxAdapter(
                child: ServiceTabBar(),
              ),

              const SliverToBoxAdapter(
                child: Divider(height: 1, thickness: 1, color: AppColors.divider),
              ),

              // Search Bar with Rotating Hint & Upload Prescription Pill
              const SliverToBoxAdapter(
                child: HomeSearchBar(),
              ),

              // Trust Strip / Express Delivery Badge
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: AppDimensions.rounded8,
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.bolt_rounded,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primaryDark,
                              fontSize: 11,
                            ),
                            children: const [
                              TextSpan(
                                text: 'Express Delivery: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'Medicines & wellness delivered to your door in 2 hours!',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Promotional Banner Carousel
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: BannerCarousel(),
                ),
              ),

              // Category Explorer (2-row horizontal scroll)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: CategorySection(),
                ),
              ),

              // Product Row 1: Cold & Cough Products (with Ad badge)
              SliverToBoxAdapter(
                child: Obx(
                  () => ProductHorizontalList(
                    title: 'Cold & Cough Products',
                    showAdBadge: true,
                    products: controller.hormonalSupport,
                  ),
                ),
              ),

              // Featured Brands Section (Screenshot 1)
              const SliverToBoxAdapter(
                child: FeaturedBrandsSection(),
              ),

              // Product Row 2: Intimate Hygiene & Grooming (Screenshot 2)
              SliverToBoxAdapter(
                child: Obx(
                  () => ProductHorizontalList(
                    title: 'Intimate hygiene & grooming',
                    products: controller.intimateHygiene,
                  ),
                ),
              ),

              // Product Row 3: Special Offers 25% Off (Screenshot 3)
              SliverToBoxAdapter(
                child: Obx(
                  () => ProductHorizontalList(
                    title: 'Get additional 25% off',
                    subtitle: 'Use code : SAVE25',
                    products: controller.menstrualCare,
                  ),
                ),
              ),

              // Pet Care Section (Screenshot 3 & 4)
              const SliverToBoxAdapter(
                child: PetCareSection(),
              ),

              // Gut Care Assessment Banner (Screenshot 4)
              const SliverToBoxAdapter(
                child: AssessmentBanner(),
              ),

              // Healthy Foods Grid 3x2 (Screenshot 5)
              const SliverToBoxAdapter(
                child: HealthyFoodsGrid(),
              ),

              // Product Row 4: Best deals on protein supplements (Screenshot 5)
              SliverToBoxAdapter(
                child: Obx(
                  () => ProductHorizontalList(
                    title: 'Best deals on protein supplements',
                    products: controller.proteinSupplements,
                  ),
                ),
              ),

              // Bottom safety spacing for bottom navigation bar
              const SliverToBoxAdapter(
                child: SizedBox(height: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
