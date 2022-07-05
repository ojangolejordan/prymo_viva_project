import 'dart:convert';

import 'package:prymo_mobile_app/app/meta/constants.dart';
import 'package:prymo_mobile_app/app/src/home/models/home.models.dart';
import 'package:http/http.dart' as http;

abstract class HomeRepository {
  Future<List<VideoModel>> getHomePosts();
}

class HomeImpl extends HomeRepository {
  @override
  Future<List<VideoModel>> getHomePosts() async {
    String authtoken = AppConstants.authToken;

    var response = await http.get(
      Uri.parse(AppConstants.baseUrl + "/api/video/"),
      headers: {"Authorization": "Token $authtoken"},
    );

    print(jsonDecode(response.body));

    var model = videoModelFromJson(response.body);

    return model;
  }
}
