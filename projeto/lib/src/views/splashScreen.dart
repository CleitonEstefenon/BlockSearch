import 'dart:async';

import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/src/helpers/SharedPrefKey.dart';
import 'package:projeto/src/helpers/SharedPrefUser.dart';
import 'package:projeto/src/views/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  var localAuth = new LocalAuthentication();

  void initState() {
    super.initState();

    localAuth.canCheckBiometrics.then((canCheckBiometrics) => {
          addBoolUserPreferences(
                  SharedPreferencesKey.HAS_BIOMETRY, canCheckBiometrics)
              .then((added) {
            Timer(Duration(milliseconds: 1500), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: Image.asset(
                        "images/logoPeq.png",
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text(
                      "BLOCKSHARE",
                      style: TextStyle(
                        fontFamily: 'Lena',
                        color: Colors.white,
                        fontSize: 50.0,
                        //fontFamily: 'RobotoMono'
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "v1.0.0",
                      style: TextStyle(
                          color: Color(0x8AFFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
