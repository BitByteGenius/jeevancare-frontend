import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

void showCarePlanUpsellModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => const CarePlanUpsellSheet(),
  );
}

class CarePlanUpsellSheet extends StatefulWidget {
  const CarePlanUpsellSheet({super.key});

  @override
  State<CarePlanUpsellSheet> createState() => _CarePlanUpsellSheetState();
}

class _CarePlanUpsellSheetState extends State<CarePlanUpsellSheet> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.to;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFDF9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Stack(
        children: [
          // Subtle Sunburst Gradient Background at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 180,
            child: CustomPaint(
              painter: _SunburstPainter(),
            ),
          ),

          // Main Modal Content
          Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Close Button Row
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.close, size: 20, color: Color(0xFF1E293B)),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Title: Save extra ₹67 on this order
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B),
                    ),
                    children: [
                      TextSpan(text: 'Save '),
                      TextSpan(
                        text: 'extra ₹67 ',
                        style: TextStyle(
                          color: Color(0xFF00785C),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(text: 'on this order'),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // "W I T H"
                const Text(
                  'W  I  T  H',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 4.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8D5B39),
                  ),
                ),

                const SizedBox(height: 12),

                // "Care Plan" Ribbon flanked by golden flourishes
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Left flourish line with diamond
                    Container(
                      width: 32,
                      height: 1,
                      color: const Color(0xFFE0A96D),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star_rounded, size: 14, color: Color(0xFFE0A96D)),
                    const SizedBox(width: 8),

                    // Maroon Care Plan Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7A2326),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF7A2326).withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Care Plan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),
                    const Icon(Icons.star_rounded, size: 14, color: Color(0xFFE0A96D)),
                    const SizedBox(width: 4),
                    Container(
                      width: 32,
                      height: 1,
                      color: const Color(0xFFE0A96D),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Benefit 1: Extra 4% discount on medicines -> Now on all products
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 3D Gift Box Icon with "New" badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3E8FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.card_giftcard_rounded,
                            size: 28,
                            color: Color(0xFF7C3AED),
                          ),
                        ),
                        Positioned(
                          bottom: -4,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: const Color(0xFF166534),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'New',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Extra 4% discount ',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                'on medicines',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF64748B),
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red.shade400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Text(
                                'on all orders above ₹249',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward_rounded, size: 14, color: Color(0xFF16A34A)),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCFCE7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  '✨ Now on all products',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF15803D),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Benefit 2: Free delivery on 20 orders
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.local_shipping_rounded,
                        size: 28,
                        color: Color(0xFF6D28D9),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Free delivery',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Applicable on 20 orders',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // "More benefits ⌄"
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'More benefits',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF8D5B39),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8D5B39),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                if (_expanded) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFFEDD5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('• Free lab test sample collection from home', style: TextStyle(fontSize: 12, color: Color(0xFF78350F))),
                        SizedBox(height: 4),
                        Text('• Unlimited free tele-consultations with top specialists', style: TextStyle(fontSize: 12, color: Color(0xFF78350F))),
                        SizedBox(height: 4),
                        Text('• Early access to flash sales & pharmacy festive deals', style: TextStyle(fontSize: 12, color: Color(0xFF78350F))),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 28),

                // "Add Care Plan" Coral Red Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      cartController.addCarePlan();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5247),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Add Care Plan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'for 3 months at ',
                              style: TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                            Text(
                              '₹165 ',
                              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '₹549',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // "I'm not interested" Link
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Text(
                    "I'm not interested",
                    style: TextStyle(
                      color: Color(0xFFFF5247),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SunburstPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFEF3C7).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, -20);
    final count = 16;
    final sweepAngle = (3.14159265 / count) * 0.5;

    for (int i = 0; i < count; i++) {
      final startAngle = (3.14159265 / count) * i * 2;
      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: size.width),
          startAngle,
          sweepAngle,
          false,
        )
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
