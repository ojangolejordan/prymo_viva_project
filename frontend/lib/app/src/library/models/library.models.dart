import 'dart:convert';

List<VisualModel> visualModelFromJson(String str) => List<VisualModel>.from(
    json.decode(str).map((x) => VisualModel.fromJson(x)));

class VisualModel {
  final String imageUrl;

  VisualModel({required this.imageUrl});

  factory VisualModel.fromJson(Map<String, dynamic> json) => VisualModel(
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}
