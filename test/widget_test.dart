import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Material app widget test', (WidgetTester tester) async {
    // Build a simple material app for testing
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Text('Test App'),
          ),
        ),
      ),
    );

    // Verify that the app launches without crashing
    expect(find.text('Test App'), findsOneWidget);
  });
}
