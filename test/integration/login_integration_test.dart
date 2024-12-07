import 'package:date_ai/screens/login_screen/login_screen.dart';
import 'package:date_ai/utils/api/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:date_ai/services/login_service.dart';
import '../screens/login_screen_test.mocks.dart';



@GenerateMocks([LoginService])
void main() {
  late MockLoginService mockLoginService;

  setUp(() {
    mockLoginService = MockLoginService();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Provider<LoginService>(
        create: (_) => mockLoginService,
        child: const LoginScreen(),
      ),
    );
  }

  group('Login Integration Test', () {
    testWidgets('displays success message on successful login', (tester) async {

      when(mockLoginService.execute(any)).thenAnswer((_) async => ApiResponse(
        data: {'accessToken': 'mock-token'},
      ));

      await tester.pumpWidget(createWidgetUnderTest());


      await tester.enterText(find.byKey(const Key('loginScreenEmail')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('loginScreenPassword')), 'password123');
      await tester.tap(find.byKey(const Key('loginScreenSubmit')));


      await tester.pumpAndSettle();


      expect(find.text('Login Successful'), findsOneWidget);
    });

    testWidgets('displays error message on login failure', (tester) async {

      when(mockLoginService.execute(any)).thenAnswer((_) async => ApiResponse(
        error: 'Invalid credentials',
      ));

      await tester.pumpWidget(createWidgetUnderTest());


      await tester.enterText(find.byKey(const Key('loginScreenEmail')), 'wrong@example.com');
      await tester.enterText(find.byKey(const Key('loginScreenPassword')), 'wrongpassword');
      await tester.tap(find.byKey(const Key('loginScreenSubmit')));


      await tester.pumpAndSettle();


      expect(find.text('Invalid credentials'), findsOneWidget);
    });

    testWidgets('displays loading indicator while login is in progress', (tester) async {

      when(mockLoginService.execute(any)).thenAnswer(
            (_) async {
          await Future.delayed(const Duration(seconds: 2));
          return ApiResponse(data: {'accessToken': 'mock-token'});
        },
      );

      await tester.pumpWidget(createWidgetUnderTest());


      await tester.enterText(find.byKey(const Key('loginScreenEmail')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('loginScreenPassword')), 'password123');
      await tester.tap(find.byKey(const Key('loginScreenSubmit')));


      await tester.pump();


      expect(find.byType(CircularProgressIndicator), findsOneWidget);


      await tester.pumpAndSettle();


      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
