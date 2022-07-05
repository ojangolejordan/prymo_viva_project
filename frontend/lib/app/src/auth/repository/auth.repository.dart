import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prymo_mobile_app/app/meta/constants.dart';
import 'package:prymo_mobile_app/app/src/auth/models/auth.models.dart';

abstract class AuthRepository {
  Future<LoginResponseModel?> loginUser(UserDataModel model);
  Future<LoginResponseModel> registerUser(UserRegisterModel model);
}

class AuthImpl extends AuthRepository {
  @override
  Future<LoginResponseModel?> loginUser(UserDataModel umodel) async {
    LoginResponseModel? lmodel;
    var response = await http.post(
        Uri.parse(AppConstants.baseUrl + "/api-token-auth/"),
        body: umodel.toJson());

    print(response.body);

    String? token = json.decode(response.body)["token"];

    if (token != null) {
      HiveRepository.saveUserName(umodel.username);
      LoginResponseModel model = LoginResponseModel(data: token, error: false);
      lmodel = model;
    } else {
      var error = json.decode(response.body)["non_field_errors"][0];
      LoginResponseModel model = LoginResponseModel(data: error, error: true);
      lmodel = model;
    }

    return lmodel;
  }

  @override
  Future<LoginResponseModel> registerUser(UserRegisterModel umodel) async {
    String authtoken = AppConstants.authToken;
    LoginResponseModel? lmodel;

    var response =
        await http.post(Uri.parse(AppConstants.baseUrl + "/api/user/"),
            headers: {
              "Authorization": "Token $authtoken",
              'Content-Type': 'application/json',
              'Accept': 'application/json'
            },
            body: json.encode(umodel.toJson()));

    var decodedJson = json.decode(response.body);

    LoginResponseModel? errorModel = checkForErrors(decodedJson);

    if (errorModel == null) {
      var aresponse = await http
          .post(Uri.parse(AppConstants.baseUrl + "/api-token-auth/"), body: {
        "username": "${umodel.username}",
        "password": "${umodel.password}"
      });

      print(aresponse.body);

      String? token = json.decode(aresponse.body)["token"];

      if (token != null) {
        HiveRepository.saveUserName(umodel.username);
        LoginResponseModel model =
            LoginResponseModel(data: token, error: false);
        lmodel = model;
      } else {
        var error = json.decode(aresponse.body)["non_field_errors"][0];
        LoginResponseModel model = LoginResponseModel(data: error, error: true);
        lmodel = model;
      }

      return lmodel;
    } else {
      return errorModel;
    }
  }
}

class LoginResponseModel {
  final bool error;
  final String data;

  const LoginResponseModel({required this.data, required this.error});
}

LoginResponseModel? checkForErrors(dynamic json) {
  LoginResponseModel? loginModel;

  List<String> fields = [
    "username",
    "email",
    "password",
    "first_name",
    "last_name",
    "non_field_errors"
  ];

  fields.forEach((field) {
    if (json[field] != null && json[field].runtimeType != String) {
      var model = new LoginResponseModel(data: json[field][0], error: true);
      loginModel = model;
    }
  });

  return loginModel;
}
