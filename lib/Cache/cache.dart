import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> setBool(String key, bool value) async {
    return await sharedPreferences?.setBool(key, value);
  }
  static setString(String key, String value) async {
    return await sharedPreferences?.setString(key, value);
  }

  static get(String key) {
    return sharedPreferences?.get(key);
  }
}
