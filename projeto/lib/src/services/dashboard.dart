import 'package:dio/dio.dart';
import 'package:projeto/src/helpers/SharedPrefKey.dart';
import 'package:projeto/src/helpers/SharedPrefUser.dart';

class Dashboard {
  Future documentsByPeriod() async {
    //pega o token do usuário salvo na SharedPeference
    String token = await getStringUserPreferences(SharedPreferencesKey.TOKEN);
    String organizationid =
        await getStringUserPreferences(SharedPreferencesKey.ORGANIZATION_ID);

    var url =
        'https://blockshare-backend.herokuapp.com/dashboard/documents_by_period/$organizationid?dataInicial=${DateTime.now().subtract(Duration(days: 7))}&dataFinal=${DateTime.now()}';

    //monta o header e envia o token de autorização
    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    //Faz o post para a API com todas as informações.
    Dio dio = new Dio();

    return await dio.get(url, options: Options(headers: header));

    // var transacao = TransactionDashboard.fromJson(response.data["resp"]["rows"][0]);
    
  }
}
