import 'package:flutter/material.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';

class PharmacyBrandItem {
  final String name;
  final String subtitle;
  final String logoUrl;
  final Color brandColor;
  final Color bgColor;

  const PharmacyBrandItem({
    required this.name,
    this.subtitle = '',
    required this.logoUrl,
    required this.brandColor,
    this.bgColor = const Color(0xFFFFF0F2),
  });
}

class PharmacyConcernItem {
  final String id;
  final String title;
  final String imageUrl;
  final Color bgColor;

  const PharmacyConcernItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.bgColor = const Color(0xFFFFECE5),
  });
}

class WomensCareItem {
  final String id;
  final String title;
  final String imageUrl;
  final Color bgColor;

  const WomensCareItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.bgColor = const Color(0xFFF3EDFF),
  });
}

class SubCategoryItem {
  final String id;
  final String title;
  final String imageUrl;

  const SubCategoryItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}

class CategoryGroup {
  final String id;
  final String name;
  final String iconUrl;
  final List<SubCategoryItem> subcategories;

  const CategoryGroup({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.subcategories,
  });
}

class EditorialStoryItem {
  final String id;
  final String title;
  final String imageUrl;

  const EditorialStoryItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}

class PharmacyData {
  // Rotating search hints
  static const List<String> searchHints = [
    'Search cough syrup',
    'Search paracetamol',
    'Search healthy snacks',
    'Search multivitamin',
    'Search pain relief spray',
    'Search baby care',
  ];

  // 24 Popular categories matching Screenshot 5 exactly
  static const List<CategoryModel> popularCategories = [
    CategoryModel(
      id: 'vitamins',
      title: 'Vitamins &\nSupplements',
      iconUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'homeopathy',
      title: 'Homeopathy',
      iconUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'monitoring_devices',
      title: 'Monitoring\nDevices',
      iconUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'protein_supplements',
      title: 'Protein\nSupplements',
      iconUrl: 'https://images.unsplash.com/photo-1579722820308-d74e571900a9?auto=format&fit=crop&w=200&q=80',
      badgeText: 'Best Seller',
      badgeType: BadgeType.orange,
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'sexual_wellness',
      title: 'Sexual\nWellness',
      iconUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'ayurvedic',
      title: 'Ayurvedic\nWellness',
      iconUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'food_nutrition',
      title: 'Food &\nNutrition',
      iconUrl: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'pet_care',
      title: 'Pet Care',
      iconUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=200&q=80',
      badgeText: 'New',
      badgeType: BadgeType.red,
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'skin_care',
      title: 'Skin Care',
      iconUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'men_care',
      title: 'Men Care',
      iconUrl: 'https://images.unsplash.com/photo-1621607512214-68297480165e?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'women_care',
      title: 'Women Care',
      iconUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'elderly_care',
      title: 'Elderly Care',
      iconUrl: 'https://images.unsplash.com/photo-1581579438747-1dc8d17bbce4?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'pain_relief',
      title: 'Pain Relief',
      iconUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'supports_braces',
      title: 'Supports &\nBraces',
      iconUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'gut_care',
      title: 'Gut Care',
      iconUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80',
      badgeText: 'Trending',
      badgeType: BadgeType.orange,
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'clean_environment',
      title: 'Clean Environment\nEssentials',
      iconUrl: 'https://images.unsplash.com/photo-1584744982491-665216d95f8b?auto=format&fit=crop&w=200&q=80',
      badgeText: 'Must Have',
      badgeType: BadgeType.orange,
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'diabetes',
      title: 'Diabetes',
      iconUrl: 'https://images.unsplash.com/photo-1628771065518-0d82f1938462?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'hair_care',
      title: 'Hair Care',
      iconUrl: 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&w=200&q=80',
      badgeText: 'Trending',
      badgeType: BadgeType.orange,
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'oral_care',
      title: 'Oral Care',
      iconUrl: 'https://images.unsplash.com/photo-1559591937-e10b144b6c31?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'cold_cough',
      title: 'Cold, Cough\n& Fever',
      iconUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80',
      badgeText: 'Must Have',
      badgeType: BadgeType.orange,
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'first_aid',
      title: 'First Aid',
      iconUrl: 'https://images.unsplash.com/photo-1603398938378-e54eab446dde?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'mental_wellness',
      title: 'Mental\nWellness',
      iconUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'baby_care',
      title: 'Baby Care',
      iconUrl: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
    CategoryModel(
      id: 'respiratory_care',
      title: 'Respiratory\nCare',
      iconUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80',
      backgroundColorHex: 0xFFFFF2EE,
    ),
  ];

  // Pet care - shop by concern (Screenshot 5)
  static const List<PharmacyConcernItem> petCareConcerns = [
    PharmacyConcernItem(
      id: 'ticks_flea',
      title: 'Ticks & Flea',
      imageUrl: 'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?auto=format&fit=crop&w=300&q=80',
      bgColor: Color(0xFFFFEDE6),
    ),
    PharmacyConcernItem(
      id: 'joint_care',
      title: 'Joint Care',
      imageUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=300&q=80',
      bgColor: Color(0xFFFFEDE6),
    ),
    PharmacyConcernItem(
      id: 'skin_coat_care',
      title: 'Skin & Coat Care',
      imageUrl: 'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?auto=format&fit=crop&w=300&q=80',
      bgColor: Color(0xFFFFEDE6),
    ),
    PharmacyConcernItem(
      id: 'digestive_health',
      title: 'Digestive Health',
      imageUrl: 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?auto=format&fit=crop&w=300&q=80',
      bgColor: Color(0xFFFFEDE6),
    ),
  ];

  // Pet care top brands 3x3 (Screenshot 1)
  static const List<PharmacyBrandItem> petTopBrands = [
    PharmacyBrandItem(
      name: 'ROYAL CANIN',
      logoUrl: 'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?auto=format&fit=crop&w=150&q=80',
      brandColor: Color(0xFFD32F2F),
    ),
    PharmacyBrandItem(
      name: 'drools',
      subtitle: 'Feed real. Feel real.',
      logoUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=150&q=80',
      brandColor: Color(0xFF1976D2),
    ),
    PharmacyBrandItem(
      name: 'Pedigree',
      logoUrl: 'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?auto=format&fit=crop&w=150&q=80',
      brandColor: Color(0xFFE65100),
    ),
    PharmacyBrandItem(
      name: 'whiskas',
      logoUrl: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=150&q=80',
      brandColor: Color(0xFF7B1FA2),
    ),
    PharmacyBrandItem(
      name: 'Himalaya',
      subtitle: 'SINCE 1930',
      logoUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=150&q=80',
      brandColor: Color(0xFF00796B),
    ),
    PharmacyBrandItem(
      name: 'JerHigh',
      subtitle: 'Feed me love',
      logoUrl: 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?auto=format&fit=crop&w=150&q=80',
      brandColor: Color(0xFF2E7D32),
    ),
    PharmacyBrandItem(
      name: 'Aniamor',
      logoUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?auto=format&fit=crop&w=150&q=80',
      brandColor: Color(0xFF1A237E),
    ),
    PharmacyBrandItem(
      name: 'VetLife',
      logoUrl: 'https://images.unsplash.com/photo-1583512603805-3cc6b41f3edb?auto=format&fit=crop&w=150&q=80',
      brandColor: Color(0xFF0288D1),
    ),
    PharmacyBrandItem(
      name: "BAKSON'S",
      subtitle: 'HOMOEOPATHY',
      logoUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=150&q=80',
      brandColor: Color(0xFFC2185B),
    ),
  ];

  // Diet & nutrition products (Screenshot 1)
  static const List<ProductModel> dietNutritionProducts = [
    ProductModel(
      id: 'diet_1',
      name: 'RiteBite Max Protein Daily 10 gm Protein Bar Choco Classic',
      packSize: '6 bars',
      rating: 4.3,
      ratingCount: 520,
      imageUrl: 'https://images.unsplash.com/photo-1622484216249-f4fb95ddc8b5?auto=format&fit=crop&w=400&q=80',
      price: 480,
      mrp: 480,
      discountPercent: 0,
      deliveryEta: 'Get by Fri, 25 Sep',
      carePlanPrice: 432,
      carePlanThreshold: 1200,
      category: 'diet_nutrition',
    ),
    ProductModel(
      id: 'diet_2',
      name: 'Tata Soulfull 0% Added Sugar Millet Muesli Super Saver Pack',
      packSize: '700 gm Muesli',
      rating: 4.2,
      ratingCount: 310,
      imageUrl: 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?auto=format&fit=crop&w=400&q=80',
      price: 379,
      mrp: 479.6,
      discountPercent: 21,
      deliveryEta: 'Get by Fri, 25 Sep',
      carePlanPrice: 341,
      carePlanThreshold: 1200,
      category: 'diet_nutrition',
    ),
    ProductModel(
      id: 'diet_3',
      name: 'Delight Almonds Roasted & Salted Healthy Snack',
      packSize: '200 gm',
      rating: 4.3,
      ratingCount: 180,
      imageUrl: 'https://images.unsplash.com/photo-1508061253366-f7da158b6d46?auto=format&fit=crop&w=400&q=80',
      price: 395,
      mrp: 450,
      discountPercent: 12,
      deliveryEta: 'Get by Fri, 25 Sep',
      carePlanPrice: 355,
      carePlanThreshold: 1200,
      category: 'diet_nutrition',
    ),
  ];

  // Category Groups for the Categories Explorer screen (Screenshots 1, 2, 4)
  static const List<CategoryGroup> categoryGroups = [
    CategoryGroup(
      id: 'hair_care',
      name: 'Hair Care',
      iconUrl: 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'hair_oils', title: 'Hair Oils', imageUrl: 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'shampoos', title: 'Shampoos &\nConditioners', imageUrl: 'https://images.unsplash.com/photo-1585751119414-ef2636f8aede?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'hair_serums', title: 'Hair Serums', imageUrl: 'https://images.unsplash.com/photo-1608248597359-216694666f7f?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'hair_creams', title: 'Hair Creams\n& Masks', imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'hair_colour', title: 'Hair Colour', imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'hair_growth', title: 'Hair Growth\nProducts', imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'essential_oils', title: 'Essential Oils', imageUrl: 'https://images.unsplash.com/photo-1608248597359-216694666f7f?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
    CategoryGroup(
      id: 'fitness_health',
      name: 'Fitness &\nHealth',
      iconUrl: 'https://images.unsplash.com/photo-1579722820308-d74e571900a9?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'plant_protein', title: 'Plant Protein', imageUrl: 'https://images.unsplash.com/photo-1579722820308-d74e571900a9?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'mass_gainers', title: 'Mass Gainers', imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'pre_post_workout', title: 'Pre/Post\nWorkout', imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
    CategoryGroup(
      id: 'sexual_wellness',
      name: 'Sexual\nWellness',
      iconUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'condoms', title: 'Condoms', imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'lubricants', title: 'Lubricants', imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
    CategoryGroup(
      id: 'vitamins_nutrition',
      name: 'Vitamins &\nNutrition',
      iconUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'multivitamins', title: 'Multivitamins', imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'calcium', title: 'Calcium &\nVitamin D', imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
    CategoryGroup(
      id: 'immunity_boosters',
      name: 'Immunity\nBoosters',
      iconUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'chyawanprash', title: 'Chyawanprash', imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'giloy', title: 'Giloy & Tulsi', imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
    CategoryGroup(
      id: 'homeopathy',
      name: 'Homeopathy',
      iconUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'homeo_diabetes', title: 'Homeopathy\nDiabetes M...', imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'homeo_sexual', title: 'Sexual\nHealth', imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'homeo_hair', title: 'Hair Care\nProducts', imageUrl: 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'homeo_piles', title: 'Piles and\nFissures', imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'homeo_fungal', title: 'Fungal\nInfection', imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'homeo_obesity', title: 'Obesity', imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'homeo_warts', title: 'Warts', imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
    CategoryGroup(
      id: 'first_aid',
      name: 'First Aid',
      iconUrl: 'https://images.unsplash.com/photo-1603398938378-e54eab446dde?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'antiseptic', title: 'Antiseptic Solution', imageUrl: 'https://images.unsplash.com/photo-1603398938378-e54eab446dde?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'bandages', title: 'Bandages', imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
    CategoryGroup(
      id: 'pain_relief',
      name: 'Pain Relief',
      iconUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'pain_sprays', title: 'Pain Relief Spray', imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'pain_gels', title: 'Pain Gels', imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
    CategoryGroup(
      id: 'stomach_care',
      name: 'Stomach Care',
      iconUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'antacids', title: 'Antacids', imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'digestives', title: 'Digestive Syrups', imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
    CategoryGroup(
      id: 'nutritional_drinks',
      name: 'Nutritional\nDrinks',
      iconUrl: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'adult_drinks', title: 'Adult Nutrition', imageUrl: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'kids_drinks', title: 'Kids Nutrition', imageUrl: 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
    CategoryGroup(
      id: 'healthy_snacks',
      name: 'Healthy\nSnacks',
      iconUrl: 'https://images.unsplash.com/photo-1508061253366-f7da158b6d46?auto=format&fit=crop&w=200&q=80',
      subcategories: [
        SubCategoryItem(id: 'peanut_butter', title: 'Peanut\nButter', imageUrl: 'https://images.unsplash.com/photo-1508061253366-f7da158b6d46?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'honey', title: 'Honey', imageUrl: 'https://images.unsplash.com/photo-1587049352847-4a222e784d38?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'cookies', title: 'Cookies', imageUrl: 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'edible_seeds', title: 'Edible Seeds\n& Nuts', imageUrl: 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'superfoods', title: 'Superfoods', imageUrl: 'https://images.unsplash.com/photo-1622484216249-f4fb95ddc8b5?auto=format&fit=crop&w=200&q=80'),
        SubCategoryItem(id: 'other_snacks', title: 'Other Snacks', imageUrl: 'https://images.unsplash.com/photo-1508061253366-f7da158b6d46?auto=format&fit=crop&w=200&q=80'),
      ],
    ),
  ];

  // Period & PMS products (Screenshot 3)
  static const List<ProductModel> periodPmsProducts = [
    ProductModel(
      id: 'pms_1',
      name: 'Nua Everyday Comfort Panty Liners Long',
      packSize: '16 pads',
      rating: 4.8,
      ratingCount: 120,
      imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=400&q=80',
      price: 94.1,
      mrp: 149,
      discountPercent: 37,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 84.7,
      carePlanThreshold: 1200,
      category: 'period_pms',
    ),
    ProductModel(
      id: 'pms_2',
      name: 'Nua All Night Comfort Sanitary Pads With Disposal Covers XXL',
      packSize: '10 pads',
      rating: 4.7,
      ratingCount: 88,
      imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=400&q=80',
      price: 194,
      mrp: 249,
      discountPercent: 22,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 175,
      carePlanThreshold: 1200,
      category: 'period_pms',
    ),
    ProductModel(
      id: 'pms_3',
      name: 'i-activ. Daily Panty Liners',
      packSize: '60 pads',
      rating: 5.0,
      ratingCount: 14,
      imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=400&q=80',
      price: 175,
      mrp: 240,
      discountPercent: 27,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 158,
      carePlanThreshold: 1200,
      category: 'period_pms',
    ),
    ProductModel(
      id: 'pms_4',
      name: 'Stayfree Dry-Max All Night Ultra-Dry',
      packSize: '42 pads',
      rating: 4.5,
      ratingCount: 461,
      imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=400&q=80',
      price: 561,
      mrp: 660,
      discountPercent: 15,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 505,
      carePlanThreshold: 1200,
      category: 'period_pms',
    ),
  ];

  // Skin Care PLP products (Screenshot 5)
  static const List<ProductModel> skinCareProducts = [
    ProductModel(
      id: 'skin_plp_1',
      name: 'Simple Kind to Skin Facial Wash Refreshing',
      packSize: '150 ml Face Wash',
      rating: 4.3,
      ratingCount: 27,
      imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=400&q=80',
      price: 334,
      mrp: 450,
      discountPercent: 26,
      deliveryEta: 'Get by Fri, 25 Sep',
      carePlanPrice: 301,
      carePlanThreshold: 1200,
      category: 'skin_care',
    ),
    ProductModel(
      id: 'skin_plp_2',
      name: 'Pilgrim A-Beauty Australia Tea Tree Purifying Gel Face Wash',
      packSize: '100 ml Face Wash',
      rating: 4.4,
      ratingCount: 14,
      imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=400&q=80',
      price: 205,
      mrp: 250,
      discountPercent: 18,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 185,
      carePlanThreshold: 1200,
      category: 'skin_care',
    ),
    ProductModel(
      id: 'skin_plp_3',
      name: 'Biluma Advance Skin Brightening Face Wash with Vitamin E | For All...',
      packSize: '100 ml Face Wash',
      rating: 4.3,
      ratingCount: 98,
      imageUrl: 'https://images.unsplash.com/photo-1621607512214-68297480165e?auto=format&fit=crop&w=400&q=80',
      price: 381,
      mrp: 450,
      discountPercent: 15,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 343,
      carePlanThreshold: 1200,
      category: 'skin_care',
    ),
  ];
  static const List<ProductModel> spotlightProducts = [
    ProductModel(
      id: 'spotlight_1',
      name: 'Organic India Moringa Powder | Manages Weakness, Fatigue & Immunity',
      packSize: '100 gm Powder',
      rating: 4.3,
      ratingCount: 1420,
      imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=400&q=80',
      price: 248,
      mrp: 275,
      discountPercent: 10,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 223,
      carePlanThreshold: 1200,
      category: 'supplements',
    ),
    ProductModel(
      id: 'spotlight_2',
      name: 'Horlicks Diabetes Plus Powder Helps Manage Blood Sugar Vanilla',
      packSize: '400 gm Powder',
      rating: 4.5,
      ratingCount: 3200,
      imageUrl: 'https://images.unsplash.com/photo-1579722820308-d74e571900a9?auto=format&fit=crop&w=400&q=80',
      price: 672,
      mrp: 820,
      discountPercent: 18,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 605,
      carePlanThreshold: 1200,
      category: 'nutrition',
    ),
    ProductModel(
      id: 'spotlight_3',
      name: 'Centrum Multivitamin for Men with Zinc, Vitamin C & Minerals',
      packSize: '50 tablets',
      rating: 4.3,
      ratingCount: 890,
      imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=400&q=80',
      price: 576,
      mrp: 720,
      discountPercent: 20,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 518,
      carePlanThreshold: 1200,
      category: 'vitamins',
    ),
  ];

  // Pet arrivals products (Screenshot 3)
  static const List<ProductModel> petArrivalsProducts = [
    ProductModel(
      id: 'pet_arr_1',
      name: 'Zippy Puppy Dog Food Chicken & Chicken Liver Chunks in Gravy...',
      packSize: '85 gm Pet Food',
      rating: 4.6,
      ratingCount: 420,
      imageUrl: 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?auto=format&fit=crop&w=400&q=80',
      price: 41.5,
      mrp: 50,
      discountPercent: 17,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 37.4,
      carePlanThreshold: 1200,
      category: 'pet_care',
    ),
    ProductModel(
      id: 'pet_arr_2',
      name: 'ho.pe. by The Honest Pet Co. Pre + Probiotics Chicken Dog Treat',
      packSize: '30 units',
      rating: 4.7,
      ratingCount: 650,
      imageUrl: 'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?auto=format&fit=crop&w=400&q=80',
      price: 855,
      mrp: 900,
      discountPercent: 5,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 770,
      carePlanThreshold: 1200,
      category: 'pet_care',
    ),
    ProductModel(
      id: 'pet_arr_3',
      name: 'Smudge Tuna with Soft Jelly Complete Adult Cat Food Can',
      packSize: '80 gm Pet Food',
      rating: 4.4,
      ratingCount: 280,
      imageUrl: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=400&q=80',
      price: 92.4,
      mrp: 110,
      discountPercent: 16,
      deliveryEta: 'Get by Thu, 24 Sep',
      carePlanPrice: 83.2,
      carePlanThreshold: 1200,
      category: 'pet_care',
    ),
  ];

  // Women's Care Essentials 2x3 (Screenshot 4)
  static const List<WomensCareItem> womensCareItems = [
    WomensCareItem(
      id: 'period_pms',
      title: 'Period & PMS',
      imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=300&q=80',
      bgColor: Color(0xFFF3EDFF),
    ),
    WomensCareItem(
      id: 'pcos_pcod',
      title: 'PCOS/PCOD',
      imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=300&q=80',
      bgColor: Color(0xFFF3EDFF),
    ),
    WomensCareItem(
      id: 'pregnancy_postpartum',
      title: 'Pregnancy &\nPostpartum',
      imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?auto=format&fit=crop&w=300&q=80',
      bgColor: Color(0xFFF3EDFF),
    ),
    WomensCareItem(
      id: 'sexual_wellness_women',
      title: 'Sexual Wellness',
      imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=300&q=80',
      bgColor: Color(0xFFF3EDFF),
    ),
    WomensCareItem(
      id: 'womens_multivitamins',
      title: "Women's\nMultivitamins",
      imageUrl: 'https://images.unsplash.com/photo-1579722820308-d74e571900a9?auto=format&fit=crop&w=300&q=80',
      bgColor: Color(0xFFF3EDFF),
    ),
    WomensCareItem(
      id: 'menopause_support',
      title: 'Menopause\nSupport',
      imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=300&q=80',
      bgColor: Color(0xFFF3EDFF),
    ),
  ];

  // Delivering care for you stories (Screenshot 4)
  static const List<EditorialStoryItem> editorialStories = [
    EditorialStoryItem(
      id: 'story_1',
      title: 'Revitalize your skin with care',
      imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
    ),
    EditorialStoryItem(
      id: 'story_2',
      title: 'Aapka hygiene,\nhumari priority',
      imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80',
    ),
    EditorialStoryItem(
      id: 'story_3',
      title: 'Dehydration ko\nkaho alvida',
      imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80',
    ),
  ];
}
