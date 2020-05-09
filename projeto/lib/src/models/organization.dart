class Organization {
  String name;

  Organization({this.name});

  Organization.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
