import 'dart:convert';

import 'package:date_ai/services/secure_storage_service.dart';

import '../utils/api/api_response.dart';
import 'config.dart';
import 'package:http/http.dart' as http;

class StartTreatmentService {
  final _url = Uri.http(Config.uri, 'treatment/start-treatment');
  final _secureStorage = SecureStorageService();

  Future<ApiResponse> execute(Map<String, dynamic> data) async {
    String? token = await _secureStorage.readData('token');
    var response = await http.post(
      _url,
      body: data,
      headers: {
        'Authorization':'Bearer $token',
      },
    ).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      print(response.statusCode);
      return ApiResponse(data: jsonDecode(response.body));
    }
    return ApiResponse(error: 'Something went wrong');
  }

}