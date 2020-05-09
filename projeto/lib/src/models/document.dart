import 'package:projeto/src/models/organization.dart';

class Document {
  String id;
  Organization organization;

  Document({this.id, this.organization});

  Document.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organization = Organization.fromJson(json['organization']);
  }
}
