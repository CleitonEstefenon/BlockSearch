import 'package:dio/dio.dart';
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

    return dio.post(
      url,
      data: formdata,
      options: Options(
        method: 'POST',
        responseType: ResponseType.stream,
        headers: header,
      ),
    );
  }

  Future search(String hash256) async {
    //pega o token do usuário salvo na SharedPeference
    String token = await getStringUserPreferences(SharedPreferencesKey.TOKEN);

    var url = 'https://blockshare-backend.herokuapp.com/transactions/search/hash/$hash256';

    //monta o header e envia o token de autorização
    Map<String, String> header = {"Authorization": "Bearer " + token};

    //Faz o post para a API com todas as informações.
    Dio dio = new Dio();

    return dio.get(url, options: Options(headers: header));
  }
}
