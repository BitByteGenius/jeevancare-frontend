import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../../home/widgets/upload_prescription_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Account', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppDimensions.rounded16,
              border: Border.all(color: AppColors.borderLight),
              boxShadow: AppDimensions.subtleShadow,
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'JC',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('JeevanCare User', style: AppTypography.headline2.copyWith(fontSize: 16)),
                      const SizedBox(height: 2),
                      Text('+91 98765 43210 • Verified', style: AppTypography.caption),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text('Healthcare & Orders', style: AppTypography.sectionTitle.copyWith(fontSize: 14)),
          const SizedBox(height: 8),
          _buildActionItem('My Medicine Orders', Icons.local_shipping_outlined, () {}),
          _buildActionItem('Lab Test Bookings', Icons.biotech_outlined, () {}),
          _buildActionItem('Doctor Consultations', Icons.medical_services_outlined, () {}),
          _buildActionItem('Prescriptions & Records', Icons.receipt_long_outlined, () => UploadPrescriptionSheet.show(context)),

          const SizedBox(height: 16),
          Text('Settings & Help', style: AppTypography.sectionTitle.copyWith(fontSize: 14)),
          const SizedBox(height: 8),
          _buildActionItem('Saved Addresses', Icons.location_on_outlined, () {}),
          _buildActionItem('Customer Support & FAQ', Icons.headset_mic_outlined, () {}),
          _buildActionItem('Terms & Privacy Policy', Icons.policy_outlined, () {}),
        ],
      ),
    );
  }

  Widget _buildActionItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: AppColors.surface,
        borderRadius: AppDimensions.rounded12,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.rounded12,
          side: const BorderSide(color: AppColors.borderLight),
        ),
        child: ListTile(
          onTap: onTap,
          shape: RoundedRectangleBorder(borderRadius: AppDimensions.rounded12),
          leading: Icon(icon, color: AppColors.primary, size: 22),
          title: Text(title, style: AppTypography.subtitle.copyWith(fontSize: 13.5)),
          trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary, size: 20),
          dense: true,
        ),
      ),
    );
  }
}
