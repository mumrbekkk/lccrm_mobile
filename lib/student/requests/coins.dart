import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_aapp/common/requests/main.dart';

import '../../common/configs/endpoints.dart';
import '../../common/configs/main_config.dart';
import '../../common/services/auth_service.dart';

class CoinsRequestsService {


  Future<dynamic> getStudentCoinHistory() async {
    final response = await MainRequestService.get(getStudentCoinHistoryEndpoint);
    return response["results"];
  }

  Future<dynamic> getStudentTotalCoinCount() async {
    final response = await MainRequestService.get(getStudentCoinCountEndpoint);
    return response["count"];
  }

}







