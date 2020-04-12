import 'package:flutter/material.dart';
import 'package:projeto/src/services/loginApi.dart';

class LoginBloc {
  LoginApi loginApi = new LoginApi();

  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  String validateEmail(String text) {
    String regularExpression =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regularExpression);

    if (text.length == 0) {
      return "Email é obrigatório";
    } else if (!regExp.hasMatch(text)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  String validatePassword(String text) {
    if (text.length == 0) {
      return "Senha é obrigatória";
    }
    return null;
  }

  Future<bool> authenticated() async =>
      LoginApi.login(emailController.text, passwordController.text)
          .then((user) {
        if (user.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      });
}
