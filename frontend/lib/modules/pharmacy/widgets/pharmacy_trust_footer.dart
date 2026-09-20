import 'package:flutter/material.dart';
import '../../../app/theme/app_dimensions.dart';

class PharmacyTrustFooter extends StatelessWidget {
  const PharmacyTrustFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 4 Trust Badges in a Row (Screenshot 3)
          Row(
            children: [
              _buildTrustBadge(
                icon: Icons.inventory_2_rounded,
                iconColor: const Color(0xFF16A34A),
                iconBgColor: const Color(0xFFDCFCE7),
                text: '100%\ngenuine\nproducts',
              ),
              const SizedBox(width: 8),
              _buildTrustBadge(
                icon: Icons.account_balance_wallet_rounded,
                iconColor: const Color(0xFF2563EB),
                iconBgColor: const Color(0xFFDBEAFE),
                text: 'Safe &\nsecure\npayments',
              ),
              const SizedBox(width: 8),
              _buildTrustBadge(
                icon: Icons.markunread_mailbox_rounded,
                iconColor: const Color(0xFFEA580C),
                iconBgColor: const Color(0xFFFFEDD5),
                text: 'No contact\ndelivery',
              ),
              const SizedBox(width: 8),
              _buildTrustBadge(
                icon: Icons.sanitizer_rounded,
                iconColor: const Color(0xFF0284C7),
                iconBgColor: const Color(0xFFE0F2FE),
                text: 'Fully\nsanitized\nworkforce',
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Wavy divider line
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 12,
              child: CustomPaint(
                painter: _WavyLinePainter(),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Slogan & Mission text
          const Text(
            'making healthcare\nunderstandable, accessible and\naffordable',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF94A3B8),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),

          // Checklist & Delivery Character
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery person at door graphic
              Container(
                width: 130,
                height: 190,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4DC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFD1C2)),
                ),
                child: Stack(
                  children: [
                    // Door panels
                    Positioned(
                      left: 10,
                      top: 10,
                      bottom: 10,
                      width: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    // Character
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0F172A),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.sports_motorsports_rounded, color: Colors.white, size: 28),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD97706),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'JEEVAN',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 28,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2563EB),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Potted plant on right
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDE8E8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.local_florist_rounded, size: 20, color: Color(0xFFF87171)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),

              // Checklist points on right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),
                    _buildCheckPoint('NABL accredited labs'),
                    const SizedBox(height: 14),
                    _buildCheckPoint('Seamless collection'),
                    const SizedBox(height: 14),
                    _buildCheckPoint('On-time reports'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrustBadge({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String text,
  }) {
    return Expanded(
      child: Container(
        height: 105,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: AppDimensions.rounded12,
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckPoint(String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            color: Color(0xFF15803D),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 12, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF334155),
            ),
          ),
        ),
      ],
    );
  }
}

class _WavyLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height / 2);

    const waveWidth = 16.0;
    const waveHeight = 4.0;
    for (double x = 0; x < size.width; x += waveWidth) {
      path.relativeQuadraticBezierTo(
        waveWidth / 4,
        -waveHeight,
        waveWidth / 2,
        0,
      );
      path.relativeQuadraticBezierTo(
        waveWidth / 4,
        waveHeight,
        waveWidth / 2,
        0,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
