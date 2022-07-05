import 'dart:convert';

import 'package:prymo_mobile_app/app/meta/constants.dart';
import 'package:http/http.dart' as http;
import 'package:prymo_mobile_app/app/src/home/models/home.models.dart';

abstract class CommentRepository {
  Future<String> addComment(Comment commentModel);
}

class CommentImpl extends CommentRepository {
  @override
  Future<String> addComment(Comment commentModel) async {
    String authtoken = AppConstants.authToken;
    var response = await http.post(
      Uri.parse(AppConstants.baseUrl + "/api/comment/"),
      headers: {
        "Authorization": "Token $authtoken",
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(commentModel.toJson()),
    );
    var decodedJson = json.decode(response.body);
    var content = decodedJson["content"];
    return content;
  }
}
