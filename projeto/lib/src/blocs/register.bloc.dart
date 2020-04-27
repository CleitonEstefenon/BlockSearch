import 'package:flutter/material.dart';
import 'package:projeto/src/services/document.dart';
import 'package:projeto/src/services/loginApi.dart';

class DocumentBLoc {
  LoginApi loginApi = new LoginApi();

  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  Future<bool> register(String path) async {
    Document().register(path);
    return null;
  }
}
