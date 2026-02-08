import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/configs/main_config.dart';
import '../../core/services/auth_service.dart';

class CoinsRequestsService {
  Future<dynamic> getStudentCoinHistory() async {
    final token = await AuthService.getAccessToken();

    final response = await http.get(
      Uri.parse("$apiV1BaseUrl/students/common/coins/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load coin history");
    }

    final data = jsonDecode(response.body);
    return data["results"];
  }

  Future<dynamic> getStudentTotalCoinCount() async {
    final token = await AuthService.getAccessToken();

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
    return data["count"];
  }

}







