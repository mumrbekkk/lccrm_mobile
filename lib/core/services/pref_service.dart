import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  final SharedPreferences _prefs;

  PrefService._(this._prefs);

  static Future<PrefService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefService._(prefs);
  }



}

