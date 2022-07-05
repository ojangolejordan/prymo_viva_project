// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

List<VideoModel> videoModelFromJson(String str) =>
    List<VideoModel>.from(json.decode(str).map((x) => VideoModel.fromJson(x)));

String videoModelToJson(List<VideoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class VideoModel {
    VideoModel({
      required  this.videoUrl,
       required this.title,
        required this.imageUrl,
    });

    final String videoUrl;
    final String title;
    final String imageUrl;

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        videoUrl: json["video_url"],
        title: json["title"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "video_url": videoUrl,
        "title": title,
        "image_url": imageUrl,
    };
}