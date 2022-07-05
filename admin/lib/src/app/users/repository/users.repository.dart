import 'package:admin/meta/constants.dart';
import 'package:admin/src/app/users/models/user.model.dart';
import 'package:http/http.dart' as http;

abstract class UsersRepository {
  Future<List<UserModel>> getUsers();
}

class UsersImpl extends UsersRepository {
  @override
  Future<List<UserModel>> getUsers() async {
    String authtoken = AppConstants.authToken;

    var response = await http.get(
      Uri.parse(AppConstants.baseUrl + "/api/user/"),
      headers: {"Authorization": "Token $authtoken"},
    );

    var model = userModelFromJson(response.body);
    return model;
  }
}
