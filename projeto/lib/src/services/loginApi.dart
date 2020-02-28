import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginApi{

  static Future<bool> validationLoginApi(String email, String password) async {

    var url = 'http://192.168.0.103:3333/authentication';

    var header = {"Content-Type" : "application/json"};

    Map params = {
      "email" : email,
      "password": password
    };

    print(params);
    print('email enviado $email');

    var bodyJson = json.encode(params);

    var response = await http.post(url, headers: header, body: bodyJson);
    
    print(response.statusCode);
    print(response.body);

    return true;
  } 
}