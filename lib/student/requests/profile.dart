import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:test_flutter_aapp/core/services/auth_service.dart';

import '../../core/configs/main_config.dart';

class ProfileRequestsService {
  dynamic getProfile() async {
    String? token = await AuthService.getAccessToken();
    final response = await http.get(
      Uri.parse("$apiV1BaseUrl/auth/profile/details/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to load profile data, response: ${response.body}");
    }
    final data = jsonDecode(response.body);
    return data;
  }

}














