import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../app/routes/app_routes.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../controllers/home_controller.dart';

class ServiceTabBar extends StatelessWidget {
  final String? activeTabId;
  final Function(String tabId)? onTabSelected;

  const ServiceTabBar({
    super.key,
    this.activeTabId,
    this.onTabSelected,
  });

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
            final effectiveSelected = activeTabId ?? controller.selectedServiceTab.value;
            final isSelected = effectiveSelected == tab.id;

            return InkWell(
              onTap: () {
                if (onTabSelected != null) {
                  onTabSelected!(tab.id);
                } else {
                  controller.selectServiceTab(tab.id);
                  if (tab.id == 'consults') {
                    if (Get.currentRoute != AppRoutes.consults) {
                      Get.toNamed(AppRoutes.consults);
                    }
                  } else {
                    if (Get.currentRoute == AppRoutes.consults) {
                      Get.back();
                    }
                    if (Get.isRegistered<DashboardController>()) {
                      final dash = Get.find<DashboardController>();
                      if (tab.id == 'pharmacy') {
                        dash.changeTab(1);
                      } else if (tab.id == 'for_you') {
                        dash.changeTab(0);
                      }
                    }
                  }
                }
              },
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

