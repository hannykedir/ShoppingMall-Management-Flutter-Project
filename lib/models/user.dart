class User {
  int id;
  String username;
  String password;
  int isadmin;

  User({this.id, this.username, this.password, this.isadmin});

  factory User.fromMap(Map<String, dynamic> json) => new User(
      id: json["id"],
      username: json["username"],
      password: json["password"],
      isadmin: json["isadmin"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "password": password,
        "isadmin": isadmin,
      };

  static Map<String, dynamic> toJson(User user) {
    return {
      "id": user.id,
      "username": user.username,
      "password": user.password,
      "isadmin": user.isadmin,
    };
  }
}
