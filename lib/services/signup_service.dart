import 'package:date_ai/utils/api/api_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class SignupService {
  final url = Uri.http(Config.uri, 'users/register');

  Future<ApiResponse> execute(Map<String,String> data) async {
    var response = await http.post(url, body: data)
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 201) {
      print(response.statusCode);
      return ApiResponse(data: null);
    }
    return ApiResponse(error: 'Failed to register');
  }
}