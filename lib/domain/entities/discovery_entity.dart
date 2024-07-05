import 'package:cine_nest/domain/entities/movie_entity.dart';

class DiscoveryEntity {
  int page;
  List<MovieEntity?>? movie;
  int totalPages;
  int totalResults;

  DiscoveryEntity({
    required this.page,
    this.movie,
    required this.totalPages,
    required this.totalResults,
  });
}
