import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/sign_in_sheet.dart';

class UploadPrescriptionScreen extends StatelessWidget {
  const UploadPrescriptionScreen({super.key});

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
            onTap: () => Get.back(),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Upload prescriptions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'and let us arrange your medicines for you',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Central Illustration (Screenshot 3)
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circular background
                  Container(
                    width: 220,
                    height: 220,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                    ),
                  ),

                  // Prescription Document Illustration
                  CustomPaint(
                    size: const Size(180, 200),
                    painter: _PrescriptionIllustrationPainter(),
                  ),
                ],
              ),
            ),
          ),

          // "Upload prescription" Coral Red Button (Screenshot 3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
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
                  'Upload prescription',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Divider(thickness: 1, color: Color(0xFFE2E8F0), height: 1),

          // Footer Security & Validity Notes (Screenshot 3)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'All uploads are encrypted & visible only to our pharmacists.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Any prescription you upload is validated before processing the order.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _showValidPrescriptionGuide(context),
                  child: const Text(
                    'What is a valid prescription?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2563EB),
                      decoration: TextDecoration.underline,
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

  void _showValidPrescriptionGuide(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What makes a prescription valid?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 14),
            _guidePoint('1. Doctor Details', 'Must include registered doctor name, degrees & registration number.'),
            _guidePoint('2. Patient Details', 'Patient name, age and date of consultation.'),
            _guidePoint('3. Medicine Details', 'Clear medicine names, dosage, and duration.'),
            _guidePoint('4. Doctor Signature', 'Original signature or stamped digital seal of physician.'),
          ],
        ),
      ),
    );
  }

  Widget _guidePoint(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, size: 16, color: Color(0xFF16A34A)),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12.5, color: Color(0xFF334155)),
                children: [
                  TextSpan(text: '$title: ', style: const TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: desc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrescriptionIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = const Color(0xFF64748B)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Paper 1 (background tilted)
    final path1 = Path()
      ..moveTo(size.width * 0.3, size.height * 0.1)
      ..lineTo(size.width * 0.9, size.height * 0.1)
      ..lineTo(size.width * 0.9, size.height * 0.85)
      ..lineTo(size.width * 0.3, size.height * 0.85)
      ..close();
    canvas.drawPath(path1, fillPaint);
    canvas.drawPath(path1, strokePaint);

    // Paper 2 (main foreground)
    final path2 = Path()
      ..moveTo(size.width * 0.2, size.height * 0.15)
      ..lineTo(size.width * 0.75, size.height * 0.15)
      ..lineTo(size.width * 0.85, size.height * 0.25)
      ..lineTo(size.width * 0.85, size.height * 0.9)
      ..lineTo(size.width * 0.2, size.height * 0.9)
      ..close();
    canvas.drawPath(path2, fillPaint);
    canvas.drawPath(path2, strokePaint);

    // Folded corner
    final foldPath = Path()
      ..moveTo(size.width * 0.75, size.height * 0.15)
      ..lineTo(size.width * 0.75, size.height * 0.25)
      ..lineTo(size.width * 0.85, size.height * 0.25);
    canvas.drawPath(foldPath, strokePaint);

    // Rx Symbol
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '℞',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w300,
          color: Color(0xFF64748B),
          fontFamily: 'serif',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(size.width * 0.28, size.height * 0.22));

    // Prescription lines
    final linePaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * 0.6, size.height * 0.28),
      Offset(size.width * 0.75, size.height * 0.28),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.28, size.height * 0.45),
      Offset(size.width * 0.6, size.height * 0.45),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.28, size.height * 0.53),
      Offset(size.width * 0.5, size.height * 0.53),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.28, size.height * 0.61),
      Offset(size.width * 0.4, size.height * 0.61),
      linePaint,
    );

    // Doctor signature flourish
    final sigPath = Path()
      ..moveTo(size.width * 0.28, size.height * 0.75)
      ..quadraticBezierTo(size.width * 0.32, size.height * 0.72, size.width * 0.35, size.height * 0.76)
      ..quadraticBezierTo(size.width * 0.38, size.height * 0.72, size.width * 0.42, size.height * 0.75);
    canvas.drawPath(sigPath, strokePaint);

    // Upward Upload Arrow (Beige / Yellow accent)
    final arrowFill = Paint()
      ..color = const Color(0xFFE5B584)
      ..style = PaintingStyle.fill;
    final arrowStroke = Paint()
      ..color = const Color(0xFF334155)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final arrowPath = Path()
      ..moveTo(size.width * 0.75, size.height * 0.62) // tip
      ..lineTo(size.width * 0.9, size.height * 0.73)
      ..lineTo(size.width * 0.82, size.height * 0.73)
      ..lineTo(size.width * 0.82, size.height * 0.88)
      ..lineTo(size.width * 0.68, size.height * 0.88)
      ..lineTo(size.width * 0.68, size.height * 0.73)
      ..lineTo(size.width * 0.6, size.height * 0.73)
      ..close();

    canvas.drawPath(arrowPath, arrowFill);
    canvas.drawPath(arrowPath, arrowStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
