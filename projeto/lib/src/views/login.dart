import 'package:flutter/material.dart';
import 'package:projeto/src/blocs/login.bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var loginBloc = new LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: null,
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: <Widget>[
              Image.asset(
                "images/logo.png",
                width: double.maxFinite,
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: loginBloc.emailController,
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
                  obscureText: true,
                  controller: loginBloc.passwordController,
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
                    setState(() {
                      if(loginBloc.fazerLogin()) {
                        print('LOGIN EFETUADO COM SUCESSO!');
                      }
                    });
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
