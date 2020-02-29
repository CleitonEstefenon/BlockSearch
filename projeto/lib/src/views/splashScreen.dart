import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto/src/views/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login()))
    );
    // Navigator.push(
    //   null,
    //   MaterialPageRoute(builder: (context) => Login()),
    // );
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
                        "Blocksearch",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
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
                        padding: EdgeInsets.only(
                          top: 20.0
                        ),
                      ),
                      Text(
                        "v1.0.0",
                        style: TextStyle(              
                          color: Color(0x8AFFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
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