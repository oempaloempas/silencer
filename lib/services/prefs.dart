import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? prefs;

  static Future<void> Init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
