import 'package:prymo_mobile_app/app/meta/constants.dart';
import 'package:prymo_mobile_app/app/src/library/models/library.models.dart';
import 'package:http/http.dart' as http;

abstract class LibraryRepository {
  Future<List<VisualModel>> getLibraryPosts();
}

class LibraryImpl extends LibraryRepository {
  @override
  Future<List<VisualModel>> getLibraryPosts() async {
    String authtoken = AppConstants.authToken;

    var response = await http.get(
      Uri.parse(AppConstants.baseUrl + "/api/visual/"),
      headers: {"Authorization": "Token $authtoken"},
    );

    var model = visualModelFromJson(response.body);

    return model;
  }
}
