import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/configs/main_config.dart';
import '../../core/services/auth_service.dart';

class ScheduleRequestsService {
  Future<dynamic> getStudentWeeklySchedule() async {
    final token = await AuthService.getAccessToken();

    final response = await http.get(
      Uri.parse("$apiV1BaseUrl/students/timetable/weekly?ordering=start_time"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load schedule");
    }

    final data = jsonDecode(response.body);
    return data;
  }
}

