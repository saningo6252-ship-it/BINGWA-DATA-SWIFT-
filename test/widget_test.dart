import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';

void main() {
  testWidgets('BingwaDataSwiftApp renders', (WidgetTester tester) async {
    await tester.pumpWidget(const BingwaDataSwiftApp());
    expect(find.text('BINGWA SOKONI DATA SWIFT'), findsOneWidget);
  });
}
