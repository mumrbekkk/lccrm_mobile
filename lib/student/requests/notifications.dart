import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_aapp/core/services/auth_service.dart';

import '../../core/configs/main_config.dart';

class NotificationsRequestsService {
  dynamic getAllNotifications() async {
    String? token = await AuthService.getAccessToken();

    final response = await http.get(
      Uri.parse("$apiV1BaseUrl/auth/notifications/all-notifications/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to load notifications");
    }
    final data = jsonDecode(response.body);
    return data;
  }

  dynamic markAllNotificationsAsRead() async {
    String? token = await AuthService.getAccessToken();

    final response = await http.post(
      Uri.parse("$apiV1BaseUrl/auth/notifications/mark-all-as-read/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to mark all notifications as read");
    }
    final data = jsonDecode(response.body);
    return data;
  }

}















