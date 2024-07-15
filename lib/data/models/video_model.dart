import 'package:cine_nest/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required super.name,
    required super.site,
    required super.key,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      name: json['name'] ?? "",
      site: json['site'] ?? "",
      key: json['key'] ?? "",
    );
  }
}
