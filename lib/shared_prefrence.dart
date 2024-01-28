import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String userNameKey = 'user_name';

  static Future<void> saveUserName(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userNameKey, userName);
  }

  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }
}