import 'package:test_flutter_aapp/common/requests/main.dart';

import '../../common/configs/endpoints.dart';
import '../../common/configs/main_config.dart';


Future<int> getCoinCount() async {
  final response = await MainRequestService.get(getStudentCoinCountEndpoint);
  return response["count"] as int;
}


Future<int> getNotificationCount() async {
  final response = await MainRequestService.get(getUnreadNotificationsCountEndpoint);
  return response["count"] as int;
}











