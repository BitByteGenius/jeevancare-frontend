import 'package:flutter_test/flutter_test.dart';
import 'package:jeevancare/main.dart';

void main() {
  testWidgets('JeevanCare smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JeevanCareApp());
    expect(find.byType(JeevanCareApp), findsOneWidget);
  });
}
