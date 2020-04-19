import 'package:flutter/material.dart';
import 'package:projeto/src/views/splashScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blocksearch',
      theme: ThemeData(
        primaryColor: Color(0xFF003eb5),
      ),
      home: SplashScreen(),
    );
  }
}