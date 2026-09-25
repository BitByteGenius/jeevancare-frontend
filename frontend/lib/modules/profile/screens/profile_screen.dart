import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/sign_in_sheet.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              if (Navigator.of(context).canPop()) {
                Get.back();
              } else if (Get.isRegistered<DashboardController>()) {
                Get.find<DashboardController>().changeTab(0);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(Icons.arrow_back, size: 20, color: Color(0xFF0F172A)),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi there!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Sign in to start your healthcare journey',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),

                // Coral Red "Sign in" Button (Screenshots 1 & 4)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => showSignInBottomSheet(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5247),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(thickness: 8, color: Color(0xFFF1F5F9), height: 8),

          // Menu List (Screenshots 1 & 4)
          _buildMenuItem(
            icon: Icons.shopping_bag_rounded,
            iconColor: const Color(0xFFEC4899),
            title: 'My orders',
            onTap: () => showSignInBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.assignment_rounded,
            iconColor: const Color(0xFF2563EB),
            title: 'My lab tests',
            onTap: () => showSignInBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.vaccines_rounded,
            iconColor: const Color(0xFF0284C7),
            title: 'My vaccines',
            onTap: () => showSignInBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.medical_services_rounded,
            iconColor: const Color(0xFF059669),
            title: 'My consultations',
            onTap: () => showSignInBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.medical_information_rounded,
            iconColor: const Color(0xFFEA580C),
            title: 'Health Records & Insights',
            badgeText: 'Beta',
            badgeBgColor: const Color(0xFFDBEAFE),
            badgeTextColor: const Color(0xFF1E40AF),
            onTap: () => showSignInBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.thumb_up_alt_rounded,
            iconColor: const Color(0xFF2563EB),
            title: 'Rate your recent purchases',
            onTap: () => showSignInBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.credit_card_rounded,
            iconColor: const Color(0xFF0284C7),
            title: 'Manage payment methods',
            onTap: () => showSignInBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.auto_awesome_rounded,
            iconColor: const Color(0xFF8B5CF6),
            title: 'NeuCoins',
            onTap: () => showSignInBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.document_scanner_rounded,
            iconColor: const Color(0xFFDB2777),
            title: 'Scan your medicines',
            badgeText: 'New',
            badgeBgColor: const Color(0xFFFCE7F3),
            badgeTextColor: const Color(0xFF9D174D),
            onTap: () => showSignInBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.storefront_rounded,
            iconColor: const Color(0xFFD97706),
            title: 'JeevanCare Stores',
            badgeText: 'New',
            badgeBgColor: const Color(0xFFFEF3C7),
            badgeTextColor: const Color(0xFF92400E),
            onTap: () => showSignInBottomSheet(context),
          ),

          const Divider(thickness: 8, color: Color(0xFFF1F5F9), height: 8),

          // Secondary Section: Need help, Settings, About us
          _buildSimpleMenuItem('Need help?', () {
            Get.rawSnackbar(
              messageText: const Text('24x7 Customer Helpline: 1800-266-4357', style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.textPrimary,
              borderRadius: 8,
              margin: const EdgeInsets.all(16),
            );
          }),
          _buildSimpleMenuItem('Settings', () {}),
          _buildSimpleMenuItem('About us', () {}),

          // Footer Banner (Screenshots 1 & 4)
          Container(
            width: double.infinity,
            color: const Color(0xFFF1F5F9),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Making healthcare',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Understandable, Accessible & Affordable',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF334155),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Made with ❤️ by JeevanCare',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? badgeText,
    Color? badgeBgColor,
    Color? badgeTextColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  if (badgeText != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: badgeBgColor ?? const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: badgeTextColor ?? const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: 20, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleMenuItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: 20, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }
}
