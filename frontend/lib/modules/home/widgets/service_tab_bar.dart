import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../controllers/home_controller.dart';

class ServiceTabBar extends StatelessWidget {
  const ServiceTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Obx(() {
        if (controller.serviceTabs.isEmpty) {
          return const SizedBox(height: 60);
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: controller.serviceTabs.map((tab) {
            final isSelected = controller.selectedServiceTab.value == tab.id;

            return InkWell(
              onTap: () => controller.selectServiceTab(tab.id),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(tab.iconBgColorHex),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      tab.icon,
                      color: Color(tab.iconColorHex),
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tab.label,
                    style: AppTypography.caption.copyWith(
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Active indicator bar
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2.5,
                    width: isSelected ? 36 : 0,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.textPrimary : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
