import 'package:date_ai/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Integration Test: Successful signup', (WidgetTester tester) async {
    // Build the app with the real SignUpScreen and SignupService
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpScreen(),
      ),
    );

    // Enter user details
    await tester.enterText(find.byType(TextField).at(0), 'test');
    await tester.enterText(find.byType(TextField).at(1), 'test@test.com');
    await tester.enterText(find.byType(TextField).at(2), 'password');

    // Tap the Sign Up button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Check for navigation
    expect(find.byType(SignUpScreen), findsNothing);
  });

  testWidgets('Integration Test: Failed signup', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpScreen(),
      ),
    );

    // Enter invalid user details
    await tester.enterText(find.byType(TextField).at(0), '');
    await tester.enterText(find.byType(TextField).at(1), 'invalid');
    await tester.enterText(find.byType(TextField).at(2), 'short');

    // Tap the Sign Up button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Check for error message
    expect(find.text('Something went wrong, please try again.'), findsOneWidget);
  });
}
