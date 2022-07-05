import 'dart:convert';

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}


class UserRegisterModel {
  UserRegisterModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterModel(
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": "$username",
        "first_name": "$email",
        "last_name": "$lastName",
        "email": "$email",
        "password": "$password",
      };
}
