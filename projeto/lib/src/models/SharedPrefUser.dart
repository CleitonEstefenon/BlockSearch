import 'package:shared_preferences/shared_preferences.dart';

Future<String> addUserPreferences(token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();    
  preferences.setString('tokenUser', token);
  return null;
}