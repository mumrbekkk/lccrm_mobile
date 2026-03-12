import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_aapp/common/requests/main.dart';

import '../../common/configs/endpoints.dart';
import '../../common/configs/main_config.dart';
import '../../common/services/auth_service.dart';


class CourseDetailService {
  Future<dynamic> getCourseDetail(int groupId) async {
    return await MainRequestService.get("$getStudentCourseDetailsEndpoint$groupId/");
  }
}






