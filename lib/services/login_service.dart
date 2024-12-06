import 'dart:convert';

import 'package:date_ai/utils/api/api_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class LoginService {
  final url = Uri.http(Config.uri, 'auth/login');

  Future<ApiResponse> execute(Map<String,String> data) async {
    var response = await http.post(url, body: data)
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      return ApiResponse(data: jsonDecode(response.body));
    }
    return ApiResponse(error: 'Failed to login');
  }
}