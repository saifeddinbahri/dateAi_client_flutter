import 'dart:convert';

import 'package:date_ai/services/secure_storage_service.dart';
import 'package:date_ai/utils/api/api_response.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class ScanImageService {
  final secureStorage = SecureStorageService();
  final url = Uri.http(Config.uri, 'scans/upload');

  Future<ApiResponse> execute(String imagePath) async {
    String? token = await secureStorage.readData('token');
    try {
      if (token != null) {
        var request = http.MultipartRequest('POST', url);
        request.files.add(await http.MultipartFile.fromPath('file', imagePath));
        request.headers['Authorization'] = 'Bearer $token';

        var response = await request.send();
        print(response.statusCode);
        if (response.statusCode == 201) {
          var data = await http.Response.fromStream(response);
          print(data.body);
          return ApiResponse(data: jsonDecode(data.body));
        }
      }
    } catch(e) {
      return ApiResponse(error: 'Something went wrong');
    }


    return ApiResponse(error: 'Failed to scan image');
  }
}