import '../configs/endpoints.dart';
import 'main.dart';

class AuthRequests {
  static Future<dynamic> getProfileDetails() async {
    return MainRequestService.get(profileDetailsEndpoint);
  }

  static Future<dynamic> getNotifications() async {
    return MainRequestService.get(getAllNotificationsEndpoint);
  }

  static Future<dynamic> getUnreadNotificationsCount() async {
    return MainRequestService.get(getUnreadNotificationsCountEndpoint);
  }


  static Future<void> markAllNotificationsAsRead() async {
    return MainRequestService.post(
      endpoint: markAllNotificationsAsReadEndpoint
    );
  }
}






