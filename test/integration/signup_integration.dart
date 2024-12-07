import 'package:date_ai/screens/signup/signup_screen.dart';
import 'package:date_ai/services/signup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([SignupService])
void main() {
  testWidgets('Integration Test: Successful signup', (WidgetTester tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpScreen(),
      ),
    );


    await tester.enterText(find.byType(TextField).at(0), 'test');
    await tester.enterText(find.byType(TextField).at(1), 'test@test.com');
    await tester.enterText(find.byType(TextField).at(2), 'password');


    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(SignUpScreen), findsNothing);
  });

  testWidgets('Integration Test: Failed signup', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpScreen(),
      ),
    );


    await tester.enterText(find.byType(TextField).at(0), '');
    await tester.enterText(find.byType(TextField).at(1), 'invalid');
    await tester.enterText(find.byType(TextField).at(2), 'short');


    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();


    expect(find.text('Something went wrong, please try again.'), findsOneWidget);
  });
}
