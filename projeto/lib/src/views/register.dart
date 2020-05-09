import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:projeto/src/blocs/register.bloc.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> key = new GlobalKey();

  final _scaffoldState = GlobalKey<ScaffoldState>();

  File _file;
  String _fileName = "";
  bool _loading = false;
  dynamic _registred;

  void selectDocument() async {
    try {
      String relativePath = await FilePicker.getFilePath(type: FileType.any);
      int fileSize = await File(relativePath).length();
      if (fileSize > 5000000) {
        showMessage("O tamanho máximo do arquivo deve ser 5MB");
      } else {
        setState(() {
          _file = File(relativePath);
          _fileName = path.basename(relativePath);
        });
        print('Nome do arquivo ' + _fileName);
      }
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

  void registrarDocumento() {
    setState(() {
      _loading = true;
    });

    DocumentBLoc().register(_file.path).then((resp) {
      setState(() {
        _loading = false;
        _registred = true;
      });
      showMessage("Documento registrado com sucesso!");
    }).catchError(() {
      setState(() {
        _loading = false;
        _registred = false;
      });
      showMessage("Ocorreu um erro ao registrar o documento");
    });
  }

  void descartarDocumento() {
    resetarFormulario();
  }

  void resetarFormulario() {
    setState(() {
      _file = null;
      _fileName = "";
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
                      _fileName,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          if (_registred != null)
            Container(
              width: double.infinity,
              child: _registred
                  ? Image.asset("images/sucesso.png", width: 128)
                  : Image.asset("images/error.png", width: 128),
            ),
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
                            Icon(Icons.delete_forever),
                            Text('Descartar arquivo'),
                          ],
                        ),
                        onPressed: () => descartarDocumento(),
                      ),
                    if (_registred == null)
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () => registrarDocumento(),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.file_upload),
                            Text('Registrar documento'),
                          ],
                        ),
                      ),
                    if (_registred != null)
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () => resetarFormulario(),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add),
                            Text('Novo documento'),
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
          'Registrar Documento',
          style: TextStyle(
            fontFamily: 'Lena',
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
      ),
      body: _file == null
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
                    Text('Toque para carregar um documento')
                  ],
                ),
              ),
            )
          : uploadFile(),
    );
  }
}
