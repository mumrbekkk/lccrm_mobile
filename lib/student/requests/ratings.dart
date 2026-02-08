import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/configs/main_config.dart';
import '../../core/services/auth_service.dart';

class RatingsRequestsService {
  Future<dynamic> getRatings() async {
    final token = await AuthService.getAccessToken();

    final response = await http.get(
      Uri.parse("$apiV1BaseUrl/students/ratings/overall-mark-rating/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load ratings");
    }

    final data = jsonDecode(response.body);
    return data;
  }

  Future<List<dynamic>> getGroupRatings() async {
    final token = await AuthService.getAccessToken();

    final response = await http.get(
      Uri.parse("$apiV1BaseUrl/students/ratings/groups-mark-rating/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load group ratings");
    }

    final data = jsonDecode(response.body);
    return data;
  }
}












