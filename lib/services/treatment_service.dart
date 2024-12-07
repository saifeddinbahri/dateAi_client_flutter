import 'dart:convert';

import 'package:date_ai/services/secure_storage_service.dart';

import '../utils/api/api_response.dart';
import 'config.dart';
import 'package:http/http.dart' as http;

class TreatmentService {
  final _url = Uri.http(Config.uri, 'treatment/user-stats');
  final _secureStorage = SecureStorageService();

  Future<ApiResponse> execute() async {
    String? token = await _secureStorage.readData('token');
    var response = await http.get(
      _url,
      headers: {
        'Authorization':'Bearer $token',
      },
    )
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      print(response.statusCode);
      return ApiResponse(data: jsonDecode(response.body));
    }
    return ApiResponse(error: 'Something went wrong');
  }
}