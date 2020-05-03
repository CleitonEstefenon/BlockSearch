import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto/src/helpers/SharedPrefKey.dart';
import 'package:projeto/src/helpers/SharedPrefUser.dart';

class Document {

  Future register(String pathFile) async {
    
    //pega o token do usuário salvo na SharedPeference
    String token = await getStringUserPreferences(SharedPreferencesKey.TOKEN);

    var url = 'https://blockshare-backend.herokuapp.com/transaction';

    //monta o header e envia o token de autorização
    Map<String, String> header = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer " + token
    };

    //carrega o documento do diretório local do celular.
    var formdata =
        FormData.fromMap({"file": await MultipartFile.fromFile(pathFile)});
    
    //Faz o post para a API com todas as informações. 
    Dio dio = new Dio();
    dio.post(
      url,
      data: formdata,
      options: Options(
        method: 'POST',
        responseType: ResponseType.stream,
        headers: header,
      ),
    ).then((response) {
      debugPrint(response.statusCode.toString());
      debugPrint("SUCESSO");
    }).catchError((error) {
      debugPrint("DEU BOSTA");
      debugPrint(error);
    });
  }
}
