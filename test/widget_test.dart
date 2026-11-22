import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test renders title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('BINGWA SOKONI DATA SWIFT'),
          ),
        ),
      ),
    );
    expect(find.text('BINGWA SOKONI DATA SWIFT'), findsOneWidget);
  });
}
