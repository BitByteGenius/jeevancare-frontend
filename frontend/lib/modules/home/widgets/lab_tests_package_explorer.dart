import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../../../app/routes/app_routes.dart';

class LabTestsPackageExplorer extends StatefulWidget {
  const LabTestsPackageExplorer({super.key});

  @override
  State<LabTestsPackageExplorer> createState() => _LabTestsPackageExplorerState();
}

class _LabTestsPackageExplorerState extends State<LabTestsPackageExplorer> {
  int selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> categories = const [
    {
      'title': 'For Women',
      'avatarUrl': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=200&q=80',
      'subPackages': [
        {
          'name': 'Adult Women',
          'imageUrl': 'https://images.unsplash.com/photo-1573496799652-408c2ac9fe98?auto=format&fit=crop&w=300&q=80',
        },
        {
          'name': 'Senior Women',
          'imageUrl': 'https://images.unsplash.com/photo-1581579438747-1dc8d17bbce4?auto=format&fit=crop&w=300&q=80',
        },
        {
          'name': 'Fitness',
          'imageUrl': 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=300&q=80',
        },
      ],
    },
    {
      'title': 'For Men',
      'avatarUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
      'subPackages': [
        {
          'name': 'Adult Men',
          'imageUrl': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80',
        },
        {
          'name': 'Senior Men',
          'imageUrl': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80',
        },
        {
          'name': 'Vitality',
          'imageUrl': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
        },
      ],
    },
    {
      'title': 'For Children',
      'avatarUrl': 'https://images.unsplash.com/photo-1543332164-6e82f355badc?auto=format&fit=crop&w=200&q=80',
      'subPackages': [
        {
          'name': 'Growth & Immunity',
          'imageUrl': 'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?auto=format&fit=crop&w=300&q=80',
        },
        {
          'name': 'Nutritional Check',
          'imageUrl': 'https://images.unsplash.com/photo-1485546246426-74dc88dec4d9?auto=format&fit=crop&w=300&q=80',
        },
      ],
    },
    {
      'title': 'X-Rays & Scans',
      'avatarUrl': 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=200&q=80',
      'subPackages': [
        {
          'name': 'Chest X-Ray',
          'imageUrl': 'https://images.unsplash.com/photo-1516549655169-df83a0774514?auto=format&fit=crop&w=300&q=80',
        },
        {
          'name': 'Ultrasound',
          'imageUrl': 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?auto=format&fit=crop&w=300&q=80',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentCategory = categories[selectedCategoryIndex];
    final subPackages = currentCategory['subPackages'] as List<Map<String, String>>;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lab tests and packages for your need',
            style: AppTypography.sectionTitle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 14),

          // Circle Avatars Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(categories.length, (index) {
              final cat = categories[index];
              final isSelected = selectedCategoryIndex == index;

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.borderMedium,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: cat['avatarUrl'] as String,
                          fit: BoxFit.cover,
                          errorWidget: (c, u, e) => const Icon(Icons.person, color: AppColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cat['title'] as String,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? const Color(0xFF1D4ED8) : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (isSelected)
                      Container(
                        height: 2.5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D4ED8),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 16),

          // Sub-packages Pink Cards Row
          Row(
            children: subPackages.map((sub) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2),
                    borderRadius: AppDimensions.rounded12,
                    border: Border.all(color: const Color(0xFFFFE4E6)),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppDimensions.radius12)),
                        child: SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: sub['imageUrl']!,
                            fit: BoxFit.cover,
                            errorWidget: (c, u, e) => const Icon(Icons.favorite, color: AppColors.primary),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: Text(
                          sub['name']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 14),

          // Explore Button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.labTests);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppDimensions.rounded8,
                ),
              ),
              child: Text(
                'Explore in ${currentCategory['title']}',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
