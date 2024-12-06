import 'package:date_ai/screens/app_shell.dart';
import 'package:date_ai/screens/login_screen/login_screen.dart';
import 'package:date_ai/services/login_service.dart';
import 'package:date_ai/utils/api/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../integration/login_integration_test.mocks.dart';





@GenerateMocks([LoginService])
void main() {
  late MockLoginService mockLoginService;

  setUp(() {
    mockLoginService = MockLoginService();
  });

  testWidgets('Displays error on failed login', (WidgetTester tester) async {
    when(mockLoginService.execute(any))
        .thenAnswer((_) async => ApiResponse(error: 'Invalid credentials'));

    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    await tester.enterText(find.byKey(const Key('loginScreenEmail')), 'user1@gmail.com');
    await tester.enterText(find.byKey(const Key('loginScreenPassword')), 'useruser12');
    await tester.tap(find.byKey(const Key('loginScreenSubmit')));
    await tester.pumpAndSettle();

    expect(find.text('Invalid credentials'), findsOneWidget);
  });

  testWidgets('Navigates to AppShell on successful login', (WidgetTester tester) async {
    when(mockLoginService.execute(any))
        .thenAnswer((_) async => ApiResponse(data: {'accessToken': 'token123'}));

    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    await tester.enterText(find.byKey(const Key('loginScreenEmail')), 'user1@gmail.com');
    await tester.enterText(find.byKey(const Key('loginScreenPassword')), 'useruser1');
    await tester.tap(find.byKey(const Key('loginScreenSubmit')));
    await tester.pumpAndSettle();

    expect(find.byType(AppShell), findsOneWidget);
  });

  testWidgets('Displays loading indicator during login', (WidgetTester tester) async {
    when(mockLoginService.execute(any)).thenAnswer(
          (_) async {
        await Future.delayed(const Duration(seconds: 4));
        return ApiResponse(data: {'accessToken': 'token123'});
      },
    );

    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    await tester.enterText(find.byKey(const Key('loginScreenEmail')), 'user1@gmail.com');
    await tester.enterText(find.byKey(const Key('loginScreenPassword')), 'useruser1');
    await tester.tap(find.byKey(const Key('loginScreenSubmit')));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
