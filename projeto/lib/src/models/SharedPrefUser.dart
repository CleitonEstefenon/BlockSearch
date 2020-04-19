import 'package:shared_preferences/shared_preferences.dart';

String savedUserPreferences;
String useBiometric;

Future<String> addUserPreferences(String key, String value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(key, value);
  return null;
}

Future<String> getUserPreferences(key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  savedUserPreferences = preferences.getString(key) ?? null;
  return useBiometric;
}

