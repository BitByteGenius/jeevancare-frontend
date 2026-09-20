import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/theme/app_colors.dart';

void showSignInBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => const SignInBottomSheet(),
  );
}

class SignInBottomSheet extends StatefulWidget {
  const SignInBottomSheet({super.key});

  @override
  State<SignInBottomSheet> createState() => _SignInBottomSheetState();
}

class _SignInBottomSheetState extends State<SignInBottomSheet> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Close Button Row
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Icon(Icons.close, size: 18, color: Color(0xFF0F172A)),
              ),
            ),
          ),

          // Title
          const Text(
            'Sign in to continue',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),

          // Mobile Number Input Box
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 14, right: 8),
                  child: Text(
                    '+91',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                Container(
                  height: 24,
                  width: 1,
                  color: const Color(0xFFCBD5E1),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A), fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                      hintText: 'Enter 10 digit mobile number',
                      hintStyle: TextStyle(fontSize: 14, color: Color(0xFF94A3B8), fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // "Get verification code" Coral Red Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.rawSnackbar(
                  messageText: const Text(
                    'OTP sent! Welcome to JeevanCare.',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: AppColors.ratingGreen,
                  borderRadius: 8,
                  margin: const EdgeInsets.all(16),
                  icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5247),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: const Text(
                'Get verification code',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // "Sign in with email" Text Button
          Center(
            child: GestureDetector(
              onTap: () {
                Get.rawSnackbar(
                  messageText: const Text('Email login option activated', style: TextStyle(color: Colors.white)),
                  backgroundColor: AppColors.textPrimary,
                  borderRadius: 8,
                  margin: const EdgeInsets.all(16),
                );
              },
              child: const Text(
                'Sign in with email',
                style: TextStyle(
                  color: Color(0xFFFF5247),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Legal Terms & Conditions Footer
          Center(
            child: Column(
              children: [
                const Text(
                  'By Signing in you agree to our',
                  style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Terms & conditions',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF64748B),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(' and ', style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B))),
                    Text(
                      'Privacy policy',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF64748B),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
