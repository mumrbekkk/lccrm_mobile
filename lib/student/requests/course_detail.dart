import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/configs/main_config.dart';
import '../../core/services/auth_service.dart';


class CourseDetailService {
  Future<dynamic> getCourseDetail(int groupId) async {
    final token = await AuthService.getAccessToken();

    final response = await http.get(
      Uri.parse("$apiV1BaseUrl/students/group-details/$groupId/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load course detail");
    }

    final data = jsonDecode(response.body);
    return data;
  }

}






