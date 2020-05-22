import 'package:flutter/material.dart';
import 'package:projeto/src/models/transaction.dart';
import 'package:projeto/src/util/date_utils.dart';

class ValidDocument extends StatelessWidget {
  final Transaction transaction;

  ValidDocument(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                        'images/aprovado.png',
                        height: 128,
                        width: 128,
                      ),
                      Text(
                        "Documento registrado",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Este documento foi registrado na rede Blockchain por ${transaction.document.organization.name} em ${DateUtils.dateToString(date: transaction.createdAt, format: "dd/MM/yyyy")} e não sofreu nenhuma alteração após o registro.",
                          textAlign: TextAlign. center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
