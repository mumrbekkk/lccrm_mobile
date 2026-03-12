import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_aapp/common/requests/main.dart';
import 'package:test_flutter_aapp/common/services/auth_service.dart';

import '../../common/configs/endpoints.dart';
import '../../common/configs/main_config.dart';

class NotificationsRequestsService {
  dynamic getAllNotifications() async {
    final response = await MainRequestService.get(getAllNotificationsEndpoint);
    return response;
  }

  dynamic markAllNotificationsAsRead() async {
    final response = await MainRequestService.post(
        endpoint: markAllNotificationsAsReadEndpoint
    );
    return response;
  }

}















