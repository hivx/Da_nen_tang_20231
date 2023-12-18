import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static Future<String> getStringData(String index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(index);
    String result = data ?? '';
    return result;
  }

  static Future<void> setStringData(String index, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(index, value);
  }

  static Future<void> setIntData(String index, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(index, value);
  }

  static Future<void> removeValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}