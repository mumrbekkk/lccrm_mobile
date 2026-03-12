import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/configs/endpoints.dart';
import '../../common/configs/main_config.dart';
import '../../common/requests/main.dart';
import '../../common/services/auth_service.dart';

class ScheduleRequestsService {
  Future<dynamic> getStudentWeeklySchedule() async {
    final response = await MainRequestService.get("$getStudentScheduleEndpoint?ordering=start_time");
    return response;
  }
}

