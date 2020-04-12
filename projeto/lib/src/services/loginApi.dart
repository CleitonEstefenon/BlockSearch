import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto/src/models/user.dart';


class LoginApi {
  static Future<User> login(String email, String password) async {

    var url = 'https://blockshare-backend.herokuapp.com/authentication';
    var header = {"Content-Type": "application/json"};
    Map params = {"email": email, "password": password};
    var bodyJson = json.encode(params);
    var response = await http.post(url, headers: header, body: bodyJson);

    User user = new User.fromJson(jsonDecode(response.body));
    user.statusCode = response.statusCode;

    return user;
  }
}
