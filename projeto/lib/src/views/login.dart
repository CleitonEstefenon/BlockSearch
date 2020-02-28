import 'package:flutter/material.dart';
import 'package:projeto/src/blocs/login.bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  LoginBloc bloc = new LoginBloc();
  
  GlobalKey<FormState> key = new GlobalKey();
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: key,
        autovalidate: validate,
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image.asset(
                  "images/logo.png",
                  width: double.maxFinite,
                  height: 200,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: bloc.emailController,
                  validator: bloc.validateEmail,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: bloc.passwordController,
                  validator: bloc.validatePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  padding: EdgeInsets.all(20),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Entrar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (key.currentState.validate()) {
                      key.currentState.save();
                      bloc.validateLogin();
                    } else {
                      setState(() {
                        validate = true;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
