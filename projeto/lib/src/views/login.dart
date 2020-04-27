import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:projeto/src/blocs/login.bloc.dart';
import 'package:projeto/src/helpers/SharedPrefKey.dart';
import 'package:projeto/src/helpers/SharedPrefUser.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc bloc = new LoginBloc();
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  GlobalKey<FormState> key = new GlobalKey();

  final _scaffoldState = GlobalKey<ScaffoldState>();

  bool _validate = false;
  bool _hasBiometry = false;
  bool _switched = false;
  String _userName = "";
  String _lastUser = "";
  bool _loginBiometricOption = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    setUpBiometricOptions();
  }

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

  void initLoading() {
    setState(() {
      _loading = true;
    });
  }

  void stopLoading() {
    setState(() {
      _loading = false;
    });
  }

  void saveBiometryOption() {
    addBoolUserPreferences(
        SharedPreferencesKey.LOGIN_BIOMETRIC_OPTION, _switched);
  }

  void setUpBiometricOptions() {
    getBoolUserPreferences(SharedPreferencesKey.HAS_BIOMETRY)
        .then((canCheckBiometrics) {
      if (canCheckBiometrics) {
        setState(() {
          _hasBiometry = true;
        });

        getStringUserPreferences(SharedPreferencesKey.USER_NAME).then((name) {
          if (name != null) {
            setState(() {
              _userName = name;
            });
          }
        });

        getStringUserPreferences(SharedPreferencesKey.USER_LOGIN).then((user) {
          if (user != null) {
            setState(() {
              _lastUser = user;
            });
          }
        });
      }
    });

    getBoolUserPreferences(SharedPreferencesKey.LOGIN_BIOMETRIC_OPTION)
        .then((loginBiometricOption) {
      if (loginBiometricOption != null) {
        setState(() {
          _loginBiometricOption = loginBiometricOption;
          _switched = loginBiometricOption;
        });
      }
    });
  }

  Future<void> _authenticateUserWithBiometry() async {
    bool isAuthenticated =
        await _localAuthentication.authenticateWithBiometrics(
            localizedReason: "Utilize o leitor biométrico para prosseguir",
            androidAuthStrings: const AndroidAuthMessages(
              cancelButton: "Cancelar",
              fingerprintHint: "Toque no sensor de digital",
              fingerprintNotRecognized: "Não reconhecido",
              fingerprintRequiredTitle: "Autenticação",
              fingerprintSuccess: "Autenticado com sucesso",
              goToSettingsButton: "Configurar biometria",
              goToSettingsDescription: "Biometria não configurada",
              signInTitle: "Autenticação",
            ),
            iOSAuthStrings: IOSAuthMessages(
              cancelButton: "Cancelar",
              goToSettingsButton: "Configurar biometria",
              goToSettingsDescription: "Biometria não configurada",
              lockOut: "Bloqueado",
            ),
            useErrorDialogs: true,
            stickyAuth: true);

    if (isAuthenticated) {
      navigateToHome();
    } else {
      stopLoading();
    }
  }

  void login() {
    initLoading();

    bloc.authenticate(_loginBiometricOption).then((isAuthenticated) {
      if (isAuthenticated) {
        if (_loginBiometricOption) {
          _authenticateUserWithBiometry();
        } else {
          navigateToHome();
        }
      } else {
        showMessage('Opss, Usuário ou senha incorretos.');
        stopLoading();
        setState(() {
          _loginBiometricOption = false;
        });
      }
    }).catchError((err) {
      stopLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.white,
      body: Form(
        key: key,
        autovalidate: _validate,
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
              Conditional.single(
                context: context,
                conditionBuilder: (BuildContext context) =>
                    _loginBiometricOption,
                widgetBuilder: (BuildContext context) => Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(_userName.isEmpty
                            ? ""
                            : _userName.substring(0, 3).toUpperCase()),
                      ),
                      title: Text(_userName.toUpperCase()),
                      subtitle: Text(_lastUser),
                      trailing: FlatButton(
                        child: Text("ALTERAR"),
                        onPressed: () {
                          setState(() {
                            _loginBiometricOption = false;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                fallbackBuilder: (BuildContext context) => (Column(
                  children: <Widget>[
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
                  ],
                )),
              ),
              Column(
                children: <Widget>[
                  if (!_loginBiometricOption && _hasBiometry)
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SwitchListTile(
                        title: Text('Utilizar biometria?'),
                        value: _switched,
                        onChanged: (bool value) {
                          setState(() {
                            _switched = value;
                          });
                        },
                        secondary: const Icon(Icons.fingerprint),
                      ),
                    )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: IgnorePointer(
                  ignoring: _loading,
                  child: MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: setUpButtonChild(),
                    onPressed: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      if (_hasBiometry && _loginBiometricOption) {
                        login();
                      } else {
                        if (key.currentState.validate()) {
                          key.currentState.save();

                          saveBiometryOption(); //Salva no shared_pref o valor do switch "Utilizar biometria?"

                          login();
                        } else {
                          setState(() {
                            _validate = true;
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
