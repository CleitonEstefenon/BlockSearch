import 'package:projeto/src/services/document.dart';

class DocumentBLoc {
  Future register(String path) {
    return Document().register(path);
  }

  Future search(String hash256) {
    return Document().search(hash256);
  }
}
