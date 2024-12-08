import 'dart:convert';

import 'package:date_ai/services/secure_storage_service.dart';

import '../utils/api/api_response.dart';
import 'config.dart';
import 'package:http/http.dart' as http;

class ScanHistoryService {
  final _url = Uri.http(Config.uri, 'scans/my-scans');
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