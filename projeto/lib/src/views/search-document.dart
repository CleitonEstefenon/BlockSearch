import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:projeto/src/blocs/register.bloc.dart';
import 'package:projeto/src/models/transaction.dart';
import 'package:projeto/src/views/valid-document.dart';
import 'package:projeto/src/views/invalid-document.dart';

class SearchDocument extends StatefulWidget {
  @override
  _SearchDocumentState createState() => _SearchDocumentState();
}

class _SearchDocumentState extends State<SearchDocument> {
  GlobalKey<FormState> key = new GlobalKey();

  final _scaffoldState = GlobalKey<ScaffoldState>();

  String _sha256;
  Transaction _transaction;
  bool _loading = false;
  dynamic _registred;

  void selectDocument() async {
    try {
      String relativePath = await FilePicker.getFilePath(type: FileType.any);
      dynamic file = File(relativePath).readAsBytesSync();

      Digest hash = sha256.convert(file);

      setState(() {
        _sha256 = hash.toString();
      });
    } catch (e) {
      showMessage('Erro ao carregar arquivo');
    }
  }

  void showMessage(String msg) {
    _scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text("$msg", textAlign: TextAlign.center),
        elevation: 5,
        duration: Duration(seconds: 4),
      ),
    );
  }

  void consultarDocumento() {
    setState(() {
      _loading = true;
    });

    DocumentBLoc().search(_sha256).then((resp) {
      if (resp.data != "") {
        setState(() {
          _loading = false;
          _registred = true;
          _transaction = Transaction.fromJson(resp.data);
        });
      } else {
        setState(() {
          _loading = false;
          _registred = false;
          _transaction = null;
        });
      }
    }).catchError(() {
      showMessage("Ocorreu um erro ao buscar o documento");
    });
  }

  void descartarDocumento() {
    resetarFormulario();
  }

  void resetarFormulario() {
    setState(() {
      _sha256 = null;
      _loading = false;
      _registred = null;
    });
  }

  Widget uploadFile() {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (_registred == null)
            Container(
              margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: Column(
                children: <Widget>[
                  Image.asset("images/file.png", width: 128),
                  ListTile(
                    title: Text(
                      _sha256,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          if (_registred != null)
            (_registred == true && _transaction != null)
                ? ValidDocument(_transaction)
                : InvalidDocument(),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: _loading
                ? [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ]
                : [
                    if (_registred == null)
                      FlatButton(
                        color: Colors.redAccent,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.cancel),
                            Text('Cancelar consulta'),
                          ],
                        ),
                        onPressed: () => descartarDocumento(),
                      ),
                    if (_registred == null)
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () => consultarDocumento(),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            Text('Consultar documento'),
                          ],
                        ),
                      ),
                    if (_registred != null)
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () => resetarFormulario(),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            Text('Nova consulta'),
                          ],
                        ),
                      ),
                  ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          'Consultar Documento',
          style: TextStyle(
            fontFamily: 'Lena',
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
      ),
      body: _sha256 == null
          ? GestureDetector(
              onTap: () => selectDocument(),
              child: Container(
                alignment: Alignment.center,
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey[300],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("images/tap.png", width: 128),
                    Text('Toque para carregar um documento já registrado')
                  ],
                ),
              ),
            )
          : uploadFile(),
    );
  }
}
