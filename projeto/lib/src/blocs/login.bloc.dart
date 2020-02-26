import 'package:flutter/cupertino.dart';

class LoginBloc {
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  fazerLogin() {
    String email = emailController.text;
    String password = passwordController.text;

    if(email == "cledianoestefenon@gmail.com" && password == "123") {
      return true;
    }
    return false;
  }
}
