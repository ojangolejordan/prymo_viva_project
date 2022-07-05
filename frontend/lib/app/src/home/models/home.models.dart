

import 'dart:convert';

List<VideoModel> videoModelFromJson(String str) => List<VideoModel>.from(json.decode(str).map((x) => VideoModel.fromJson(x)));

String videoModelToJson(List<VideoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoModel {
    VideoModel({
        required this.id,
        required this.title,
        required this.imageUrl,
        required this.videoUrl,
        required this.comments,
    });

    final int id;
    final String title;
    final String imageUrl;
    final String videoUrl;
    final List<Comment> comments;

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        title: json["title"],
        imageUrl: json["image_url"],
        videoUrl: json["video_url"],
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image_url": imageUrl,
        "video_url": videoUrl,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    Comment({
        required this.content,
        required this.video,
        required this.name,
        required this.createdOn,
    });

    final String content;
    final int video;
    final String name;
    final DateTime createdOn;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        content: json["content"],
        video: json["video"],
        name: json["name"],
        createdOn: DateTime.parse(json["created_on"]),
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "video": video,
        "name": name,
        "created_on": createdOn.toIso8601String(),
    };
}
