import 'package:flutter/material.dart';

class InvalidDocument extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/alerta.png',
                      height: 128,
                      width: 128,
                    ),
                    Text(
                      "Documento não registrado",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                subtitle: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Este documento não está registrado na rede Blockchain ou sofreu alguma alteração.",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
