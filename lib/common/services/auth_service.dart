import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/main_config.dart';


class AuthService {
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




































