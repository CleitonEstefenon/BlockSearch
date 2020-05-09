
import 'package:projeto/src/models/Document.dart';
import 'package:projeto/src/util/date_utils.dart';

class Transaction {
  String txid;
  bool confirmed;
  DateTime createdAt;
  Document document;

  Transaction({this.txid, this.confirmed, this.createdAt, this.document});

  Transaction.fromJson(Map<String, dynamic> json) {
    txid = json['txid'];
    confirmed = json['confirmed'];
    createdAt = DateUtils.stringToDate(json['createdAt']);
    document = Document.fromJson(json['document']);
  }
}
