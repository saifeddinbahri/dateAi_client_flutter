import 'package:date_ai/screens/signup/signup_screen.dart';
import 'package:date_ai/services/signup_service.dart';
import 'package:date_ai/utils/api/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'signup_screen_test.mocks.dart';


@GenerateMocks([SignupService])
void main() {
  late MockSignupService mockSignupService;

  setUp(() {
    mockSignupService = MockSignupService();
  });

  Future<void> buildSignUpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpScreen(),
      ),
    );
  }

  testWidgets('Displays error message on failed signup', (WidgetTester tester) async {
    // Arrange
    when(mockSignupService.execute(any)).thenAnswer((_) async => ApiResponse(error: 'Failed to register'));

    await buildSignUpScreen(tester);

    // Enter user details
    await tester.enterText(find.byType(TextField).at(0), 'test');
    await tester.enterText(find.byType(TextField).at(1), 'test@test.com');
    await tester.enterText(find.byType(TextField).at(2), 'password');

    // Tap the Sign Up button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify
    expect(find.text('Something went wrong, please try again.'), findsOneWidget);
    verify(mockSignupService.execute({'name': 'test', 'email': 'test@test.com', 'password': 'password'})).called(1);
  });

  testWidgets('Navigates back on successful signup', (WidgetTester tester) async {
    // Arrange
    when(mockSignupService.execute(any)).thenAnswer((_) async => ApiResponse(data: null));

    await buildSignUpScreen(tester);

    // Enter user details
    await tester.enterText(find.byType(TextField).at(0), 'test');
    await tester.enterText(find.byType(TextField).at(1), 'test@test.com');
    await tester.enterText(find.byType(TextField).at(2), 'password');

    // Tap the Sign Up button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify
    verify(mockSignupService.execute({'name': 'test', 'email': 'test@test.com', 'password': 'password'})).called(1);
  });
}
