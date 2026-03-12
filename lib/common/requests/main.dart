import 'dart:convert';

import 'package:http/http.dart' as http;

import '../configs/endpoints.dart';
import '../exceptions.dart';
import '../services/auth_service2.dart';

class MainRequestService {
  static Future<dynamic> login({required String username, required String password}) async {
    final response = await http.post(
      Uri.parse(loginEndpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {
            "username": username,
            "password": password,
          }
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Invalid credentials");
    }

    final data = jsonDecode(response.body);

    return data;
  }

  static Future<dynamic> get(String endpoint) async {
    final String? token = await AuthService2.getAccessToken();

    if (token == null) {
      throw UnauthorizedException();
    }

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        "Failed request. Status: ${response.statusCode}, Body: ${response.body}",
      );
    }

    final data = jsonDecode(response.body);
    return data;
  }

  static Future<dynamic> post({required String endpoint, dynamic body}) async {
    String? token = await AuthService2.getAccessToken();

    if (token == null) {
      throw UnauthorizedException();
    }

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: body != null ? jsonEncode(body) : null,
    );

    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        "Failed request. Status: ${response.statusCode}, Body: ${response.body}",
      );
    }

    if (response.body.isNotEmpty) {
      return jsonDecode(response.body);
    }

    return null;
  }
}




