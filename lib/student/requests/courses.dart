import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/configs/main_config.dart';
import '../../core/services/auth_service.dart';


class CoursesRequestsService {
  Future<dynamic> getCourses() async {
    final token = await AuthService.getAccessToken();

    final response = await http.get(
      Uri.parse("$apiV1BaseUrl/students/student-groups/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load courses");
    }

    final data = jsonDecode(response.body);
    return data;
  }

}














