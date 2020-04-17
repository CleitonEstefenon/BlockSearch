import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/src/blocs/login.bloc.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc bloc = new LoginBloc();

  GlobalKey<FormState> key = new GlobalKey();

  final _scaffoldState = GlobalKey<ScaffoldState>();

  bool validate = false;

  bool _loading = false;

  void showMessage(String msg) {
    _scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(
          "$msg",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void navigateToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  Widget setUpButtonChild() {
    if (!_loading) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "Entrar",
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(11.2),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
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
                      labelText: "E-mail", border: OutlineInputBorder()),
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
                      labelText: "Senha", border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: setUpButtonChild(),
                  onPressed: () {
                    if (key.currentState.validate()) {
                      key.currentState.save();

                      SystemChannels.textInput.invokeMethod('TextInput.hide');

                      setState(() {
                        _loading = true;
                      });

                      bloc.authenticated().then((isAuthenticated) {
                        if (isAuthenticated) {
                          navigateToHome();
                        } else {
                          showMessage('Nenhum usuário encontrado.');
                          setState(() {
                            _loading = false;
                          });
                        }
                      });
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
