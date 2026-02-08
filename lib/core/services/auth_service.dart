import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/main_config.dart';


class AuthService {
  // Login
  static Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$apiV1BaseUrl/auth/login/"),
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

    final prefs = await SharedPreferences.getInstance();

    prefs.setString(
        "tokenAccessedTime",
        DateTime.now().toIso8601String()
    );

    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is String) {
        await prefs.setString(key, value);
      } else if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is bool) {
        await prefs.setBool(key, value);
      }
    }

    return data["role"];
  }

  static Future<String?> getValidatedAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    final tokenAccessedTime = DateTime.tryParse(prefs.getString("tokenAccessedTime") ?? "");
    final String? access = prefs.getString("access");
    final String? refresh = prefs.getString("refresh");

    if (access == null || refresh == null || tokenAccessedTime == null) {
      return null;
    }

    final hasTwoHoursPassed = DateTime.now().difference(tokenAccessedTime).inHours >= 2;
    if (!hasTwoHoursPassed) {
      return access;
    }

    final body = await refreshAccessToken(refresh);

    final String newAccess = body["access"];
    final String newRefresh = body["refresh"];

    await prefs.setString("access", newAccess);
    await prefs.setString("refresh", newRefresh);
    await prefs.setString(
      "tokenAccessedTime",
      DateTime.now().toIso8601String(),
    );

    return newAccess;
  }

  static Future<String?> getAccessToken() async {
    return await getValidatedAccessToken();
  }

  static Future<Map<String, dynamic>> refreshAccessToken(String refresh) async {
    final response = await http.post(
      Uri.parse("$apiV1BaseUrl/auth/refresh/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "refresh": refresh,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Invalid credentials or refresh token lifetime is out");
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Check Login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("access") != null;
  }

  // Get Role
  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

}




































