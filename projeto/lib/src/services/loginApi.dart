import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String message;
  String token;
  String name;
  String email;

  User({this.message, this.token, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    name = json['name'];
    email = json['email'];
  }
}

class LoginApi {
  static Future<User> validationLoginApi(String email, String password) async {
    // Conexão local Host. Trocar o IP pelo IP da maquina que está executando e liberar a porta 3333 no firewall
    //var url = 'http://192.168.0.103:3333/authentication';

    //conexão no servidor heroku
    var url = 'https://blockshare-backend.herokuapp.com/authentication';

    var header = {"Content-Type": "application/json"};

    Map params = {"email": email, "password": password};

    var bodyJson = json.encode(params);

    var response = await http.post(url, headers: header, body: bodyJson);

    var user = new User.fromJson(jsonDecode(response.body));

    Map retorno = {"message": user.message, "token": user.token, "name": user.name, 'email': user.email, 'statusCode': response.statusCode};

    print(retorno);

  }
}
