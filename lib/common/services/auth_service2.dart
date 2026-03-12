import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_aapp/common/requests/main.dart';


// According to SRP this layer is responsible for SharedPreference
class AuthService2 {
  static Future<String> login(String username, String password) async {
    final data = await MainRequestService.login(
        username: username,
        password: password
    );

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("access", data["access"]);
    await prefs.setString("refresh", data["refresh"]);
    await prefs.setString("role", data["role"]);
    await prefs.setInt("user_id", data["user_id"]);
    await prefs.setString("username", data["username"]);

    if (data["picture"] != null) {
      await prefs.setString("picture", data["picture"]);
    }

    return data["role"];
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("access");
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("refresh");
  }
}




