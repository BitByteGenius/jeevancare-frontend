import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../home/widgets/location_header.dart';
import '../../home/widgets/service_tab_bar.dart';
import '../controllers/pharmacy_controller.dart';
import '../widgets/pharmacy_search_header.dart';
import '../widgets/sawaal_uthao_hero_banner.dart';
import '../widgets/pharmacy_quick_actions.dart';
import '../widgets/pharmacy_promo_banner.dart';
import '../widgets/pharmacy_popular_categories_grid.dart';
import '../widgets/pet_care_concern_section.dart';
import '../widgets/pet_top_brands_section.dart';
import '../widgets/pharmacy_spotlight_section.dart';
import '../widgets/diet_nutrition_section.dart';
import '../widgets/pet_arrivals_section.dart';
import '../widgets/pharmacy_survey_banner.dart';
import '../widgets/womens_care_section.dart';
import '../widgets/delivering_care_section.dart';
import '../widgets/glp1_weight_management_banner.dart';
import '../widgets/pharmacy_trust_footer.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure PharmacyController is initialized
    if (!Get.isRegistered<PharmacyController>()) {
      Get.put(PharmacyController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 600));
          },
          color: AppColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // 1. Top Location Header (Buxar, Profile, Cart)
              const SliverToBoxAdapter(
                child: LocationHeader(),
              ),

              // 2. Service Tab Bar with "Pharmacy" Active (Black underline)
              const SliverToBoxAdapter(
                child: ServiceTabBar(activeTabId: 'pharmacy'),
              ),

              const SliverToBoxAdapter(
                child: Divider(height: 1, thickness: 1, color: AppColors.divider),
              ),

              // 3. Search Bar with Rotating Hint & "Categories" dark pill button
              const SliverToBoxAdapter(
                child: PharmacySearchHeader(),
              ),

              // 4. "Sawaal Uthao" Genuine Medicine Hero Banner
              const SliverToBoxAdapter(
                child: SawaalUthaoHeroBanner(),
              ),

              // 5. Dual Quick Actions (Order with prescription / Call to order)
              const SliverToBoxAdapter(
                child: PharmacyQuickActions(),
              ),

              // 6. Skincare Offer Banner (Cetaphil 15% Off)
              const SliverToBoxAdapter(
                child: PharmacyPromoBanner(),
              ),

              // 7. Popular Categories (4 columns x 6 rows = 24 categories with badges)
              const SliverToBoxAdapter(
                child: PharmacyPopularCategoriesGrid(),
              ),

              // 8. Pet care - shop by concern (Screenshot 5)
              const SliverToBoxAdapter(
                child: PetCareConcernSection(),
              ),

              // 9. Pet care top brands (3x3 circular logos, Screenshot 1)
              const SliverToBoxAdapter(
                child: PetTopBrandsSection(),
              ),

              // 10. In the spotlight [Ad] (Screenshot 1)
              const SliverToBoxAdapter(
                child: PharmacySpotlightSection(),
              ),

              // 11. Diet & Nutrition Section (Screenshot 1)
              const SliverToBoxAdapter(
                child: DietNutritionSection(),
              ),

              // 12. Pet Arrivals Section ("Get your paws on latest arrivals", Screenshot 3)
              const SliverToBoxAdapter(
                child: PetArrivalsSection(),
              ),

              // 13. Medical Insights / Antibiotics Survey Banner (Screenshot 3)
              const SliverToBoxAdapter(
                child: PharmacySurveyBanner(),
              ),

              // 14. Nurture your well-being with Women's Care Essentials (Screenshot 4)
              const SliverToBoxAdapter(
                child: WomensCareSection(),
              ),

              // 15. Delivering care for you (Editorial story photo cards, Screenshot 4)
              const SliverToBoxAdapter(
                child: DeliveringCareSection(),
              ),

              // 16. Blockbuster GLP-1 Weight Management Solutions Banner (Screenshot 4)
              const SliverToBoxAdapter(
                child: Glp1WeightManagementBanner(),
              ),

              // 17. Trust Badges, Mission & Delivery Character Footer (Screenshot 3)
              const SliverToBoxAdapter(
                child: PharmacyTrustFooter(),
              ),

              // 18. Bottom spacing for navigation bar
              const SliverToBoxAdapter(
                child: SizedBox(height: 36),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
