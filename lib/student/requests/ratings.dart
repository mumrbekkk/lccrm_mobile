import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/configs/endpoints.dart';
import '../../common/configs/main_config.dart';
import '../../common/requests/main.dart';
import '../../common/services/auth_service.dart';

class RatingsRequestsService {
  Future<dynamic> getRatings() async {
    final response = await MainRequestService.get(getStudentRatingsEndpoint);
    return response;
  }

  Future<List<dynamic>> getGroupRatings() async {
    final response = await MainRequestService.get(getStudentGroupRatingsEndpoint);
    return response;
  }
}












