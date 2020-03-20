import 'package:flutter/material.dart';
import 'floatButtons.dart';

class Home extends StatefulWidget {



  @override
  _HomeState createState() => _HomeState();
}

//O SingleTickerProviderStateMixin vai
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BLOCKSHARE",
          style: TextStyle(
            fontFamily: 'Lena',
            color: Colors.white,
            fontSize: 25.0,
          ),
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Graficos aqui'
            )
          ],
        ),
      ),
      floatingActionButton: FloatButton(),
    );
  }
}

