import 'package:date_ai/services/login_service.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'login_service_test.mocks.dart';



@GenerateMocks([http.Client])
void main() {
  late LoginService loginService;
  late MockClient mockHttpClient;

  setUp(() {
    loginService = LoginService();
    mockHttpClient = MockClient();
  });

  test('Return data on successful login', () async {
    final mockResponse = http.Response('{"accessToken": "userToken123"}', 200);

    when(mockHttpClient.post(
      Uri.parse('http://192.168.1.13:3000/auth/login'),
      body: {'email': 'saif@gmail.com', 'password': 'saifsaif'},
    )).thenAnswer((_) async => mockResponse);

    final result = await loginService.execute({'email': 'saif@gmail.com', 'password': 'saifsaif'});
    print(result.data);
    expect(result.data['accessToken'], 'userToken123');
    expect(result.error, isNull);
  });

  test('Return error on failed login', () async {
    final mockResponse = http.Response('Unauthorized', 401);

    when(mockHttpClient.post(
      Uri.parse('http://192.168.1.13:3000/auth/login'),
      body: {'email': 'saif@gmail.com', 'password': 'saif1234'},
    )).thenAnswer((_) async => mockResponse);

    final result = await loginService.execute({'email': 'saif@gmail.com', 'password': 'saif1234'});
    expect(result.data, isNull);
    expect(result.error, 'Failed to login');
  });

  test('Timeout error', () async {
    when(mockHttpClient.post(
      Uri.parse('http://192.168.1.13:3000/auth/login'),
      body: {'email': 'saif@gmail.com', 'password': 'saifsaif'},
    )).thenThrow(TimeoutException('Request timeout'));

    final result = await loginService.execute({'email': 'saif@gmail.com', 'password': 'saifsaif'});
    expect(result.data, isNull);
    expect(result.error, isNotNull);
  });

  test('Unexpected errors', () async {
    when(mockHttpClient.post(
      Uri.parse('http://192.168.1.13:3000/auth/login'),
      body: {'email': 'saif@gmail.com', 'password': 'saifsaif'},
    )).thenThrow(Exception('Unexpected error'));

    final result = await loginService.execute({'email': 'test@test.com', 'password': 'password'});
    expect(result.data, isNull);
    expect(result.error, isNotNull);
  });
}
