import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManger {
  static Future<void> saveUserCredentials(
      {required String userName, required String password}) async {
    String userData = json.encode({"userName": userName, "password": password});
    log(userData);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("USER_CREDENTIALS", userData);
  }

  static Future<Map<String, dynamic>?> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("USER_CREDENTIALS");
    if (user == null) {
      return null;
    } else {
      log(user);
      Map<String, dynamic> userData = json.decode(user);
      return userData;
    }
  }

  static Future<void> removeUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("USER_CREDENTIALS");
  }
}
