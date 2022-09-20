class User {
  int? id;
  String? name;
  String? email;
  String? image;
  int? token;

  User({this.id, this.name, this.email, this.image, this.token});

  //function for convert json data to user model
  factory User.fromJson(Map<String, dynamic> json) {

    return User(
      // id: json['user']['id'],
      // name: json['user']['name'],
      // email: json['user']['email'],
      // image: json['user']['image'],
      token: json['token'],
    );
  }
}
