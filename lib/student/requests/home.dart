import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_aapp/common/services/auth_service.dart';

import '../../common/configs/endpoints.dart';
import '../../common/configs/main_config.dart';
import '../../common/requests/main.dart';

class HomeRequestsService {
  dynamic getAttendanceStatistics() async {
    final response = await MainRequestService.get(getStudentAttendanceStatisticsEndpoint);
    return response;
  }
}














