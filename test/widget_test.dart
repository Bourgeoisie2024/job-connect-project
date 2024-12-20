import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_connect/main.dart';

void main() {
  testWidgets('JobConnect app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const JobConnectApp());

    // Verify that the splash screen shows up
    expect(find.text('JobConnect'), findsOneWidget);
    expect(find.text('Your Career Journey Starts Here'), findsOneWidget);
  });
}
