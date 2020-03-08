import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/src/blocs/login.bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  LoginBloc bloc = new LoginBloc();
  
  GlobalKey<FormState> key = new GlobalKey();

  bool validate = false;


  Future<bool> _endApplication() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Sair do App?'),
        content: Text('Você deseja SAIR da aplicação?'),
        actions: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text('Não'),
            onPressed: () {
              Navigator.of(context).pop();
            }            
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text('Sim'),
            onPressed: () { 
              SystemNavigator.pop();
            },
          ),
        ],
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _endApplication,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: key,
          autovalidate: validate,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, 
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                    right: 50,
                    left: 50,
                  ),
                  child: Image.asset(
                    "images/logo.png",
                    width: 150,
                    height: 150,
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
      ),
    );
  }
}
