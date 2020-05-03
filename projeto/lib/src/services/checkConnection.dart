import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto/src/helpers/SharedPrefKey.dart';
import 'package:projeto/src/helpers/SharedPrefUser.dart';

class Document {
  Future register(String pathFile) async {
    String token = await getStringUserPreferences(SharedPreferencesKey.TOKEN);

    var url = 'https://blockshare-backend.herokuapp.com/transaction';

    Map<String, String> header = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer " + token
    };

    Dio dio = new Dio();
    var formdata =
        FormData.fromMap({"file": await MultipartFile.fromFile(pathFile)});

    dio
        .post(
      url,
      data: formdata,
      options: Options(
        method: 'POST',
        responseType: ResponseType.stream,
        headers: header,
      ),
    )
        .then((response) {
      debugPrint(response.statusCode.toString());
      debugPrint("SUCESSO");
    }).catchError((error) {
      debugPrint("DEU BOSTA");
      debugPrint(error);
    });
  }
}
