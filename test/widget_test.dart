import 'package:flutter_test/flutter_test.dart';
import 'package:bingwa_data_swift_/main.dart' as app;

void main() {
  testWidgets('App starts smoke test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('BINGWA SOKONI DATA SWIFT'), findsOneWidget);
  });
}
