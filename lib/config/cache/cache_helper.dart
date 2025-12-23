import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  static SharedPreferences? _sharedPreferences;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await _sharedPreferences?.setString(key, value) ?? false;
  }

  static String? getString(String key) {
    return _sharedPreferences?.getString(key);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    return await _sharedPreferences?.setStringList(key, value) ?? false;
  }

  static List<String>? getStringList(String key) {
    return _sharedPreferences?.getStringList(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences?.setBool(key, value) ?? false;
  }

  static bool? getBool(String key) {
    return _sharedPreferences?.getBool(key);
  }

  static Future<bool> remove(String key) async {
    return await _sharedPreferences?.remove(key) ?? false;
  }

  static Future<bool> clear() async {
    return await _sharedPreferences?.clear() ?? false;
  }

  static Future<void> setSecureString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecureString(String key) async {
    return await _secureStorage.read(key: key);
  }

  static Future<void> removeSecureString(String key) async {
    await _secureStorage.delete(key: key);
  }

  static Future<void> clearSecureStorage() async {
    await _secureStorage.deleteAll();
  }
}

