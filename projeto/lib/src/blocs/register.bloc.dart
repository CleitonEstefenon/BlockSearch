import 'package:projeto/src/services/document.dart';

class DocumentBLoc {
  Future<bool> register(String path) async {
    Document().register(path);
    return null;
  }
}
