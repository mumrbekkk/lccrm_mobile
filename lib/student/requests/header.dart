import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/configs/main_config.dart';


Future<int> getCoinCount() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("access");

  if (token == null) {
    throw Exception("Not authenticated");
  }


  final response = await http.get(
    Uri.parse("$apiV1BaseUrl/students/common/coins/count/"),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );
  if (response.statusCode != 200) {
    throw Exception("Failed to load coin count");
  }
  final data = jsonDecode(response.body);

  return data["count"] as int;
}


Future<int> getNotificationCount() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("access");

  if (token == null) {
    throw Exception("Not authenticated");
  }


  final response = await http.get(
    Uri.parse("$apiV1BaseUrl/auth/notifications/unread-notifications-count/"),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );
  if (response.statusCode != 200) {
    throw Exception("Failed to load coin count");
  }
  final data = jsonDecode(response.body);

  return data["count"] as int;
}











