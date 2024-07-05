import 'package:cine_nest/data/models/movie_model.dart';
import 'package:cine_nest/domain/entities/discovery_entity.dart';

class DiscoveryModel extends DiscoveryEntity {
  DiscoveryModel({
    required super.page,
    super.movie,
    required super.totalPages,
    required super.totalResults,
  });

  factory DiscoveryModel.fromJson(Map<String, dynamic> json) {
    return DiscoveryModel(
      page: json['page'],
      movie: (json['results'] as List<dynamic>)
          .map((movieJson) => MovieModel.fromJson(movieJson))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
