class TransactionDashboard {
  String id;
  bool confirmed;
  int confirmations;
  DateTime createdAt;

  TransactionDashboard({
    this.id,
    this.confirmed,
    this.confirmations,
    this.createdAt,
  });

  TransactionDashboard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    confirmations = json['confirmations'];
    confirmed = json['confirmed'];
    createdAt = DateTime.parse(json['createdAt']);
  }
}
