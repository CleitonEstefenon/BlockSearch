import 'package:projeto/src/helpers/SharedPrefKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> addBoolUserPreferences(SharedPreferencesKey key, bool value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.setBool(key.toString(), value);
}

Future<bool> addStringUserPreferences(SharedPreferencesKey key, String value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.setString(key.toString(), value);
}

Future<bool> getBoolUserPreferences(SharedPreferencesKey key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool(key.toString()) ?? null;
}

Future<String> getStringUserPreferences(SharedPreferencesKey key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString(key.toString()) ?? null;
}
