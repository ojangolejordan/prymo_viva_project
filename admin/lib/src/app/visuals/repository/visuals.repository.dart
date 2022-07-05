import 'package:admin/meta/constants.dart';
import 'package:admin/src/app/visuals/models/visuals.models.dart';
import 'package:http/http.dart' as http;

abstract class VisualsRepository {
  Future<List<VisualModel>> getVisualsPosts();
}

class VisualsImpl extends VisualsRepository {
  @override
  Future<List<VisualModel>> getVisualsPosts() async {
    String authtoken = AppConstants.authToken;

    var response = await http.get(
      Uri.parse(AppConstants.baseUrl + "/api/visual/"),
      headers: {"Authorization": "Token $authtoken"},
    );

    var model = visualModelFromJson(response.body);

    return model;
  }
}
