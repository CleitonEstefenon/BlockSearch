class User {

  String message;
  String token;
  String name;
  String email;
  String organization;
  int statusCode = 400;


  User({this.message, this.token, this.name, this.email, this.organization, this.statusCode});

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    name = json['name'];
    email = json['email'];
    organization = json['organization'];
  }

}
