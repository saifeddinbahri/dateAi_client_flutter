import 'package:date_ai/services/signup_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'signup_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late SignupService signupService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    signupService = SignupService();
  });

  test('Returns success for valid data', () async {
    when(mockClient.post(
      signupService.url,
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response('', 201));

    final response = await signupService.execute({'name': 'user1', 'email': 'user1@gmail.com', 'password': 'useruser1'});

    expect(response.error, isNull);
    expect(response.data, isNull);
  });

  test('Returns error for invalid data', () async {
    when(mockClient.post(
      Uri.parse('http://192.168.1.13:3000/users/register'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response('', 400));

    final response = await signupService.execute({'name': '', 'email': 'invalid', 'password': ''});

    expect(response.error, 'Failed to register');
    expect(response.data, isNull);
  });


}
