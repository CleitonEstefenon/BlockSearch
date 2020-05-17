class TransactionDashboard {
  String id;
  DateTime createdAt;

  TransactionDashboard({this.id, this.createdAt});

  TransactionDashboard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = DateTime.parse(json['createdAt']);
  }
}
