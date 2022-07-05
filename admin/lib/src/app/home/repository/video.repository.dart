import 'package:admin/meta/constants.dart';
import 'package:admin/src/app/home/models/video.models.dart';
import 'package:http/http.dart' as http;

abstract class VideoRepository {
  Future<List<VideoModel>> getVideos();
}

class VideoImpl extends VideoRepository {
  @override
  Future<List<VideoModel>> getVideos() async {
    String authtoken = AppConstants.authToken;

    var response = await http.get(
      Uri.parse(AppConstants.baseUrl + "/api/video/"),
      headers: {"Authorization": "Token $authtoken"},
    );

    var model = videoModelFromJson(response.body);

    return model;
  }
}

