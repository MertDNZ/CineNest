import 'package:cine_nest/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.adult,
    required super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.releaseDate,
    required super.title,
    required super.voteAverage,
    required super.voteCount,
  });
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'].toString() ?? "",
      genreIds: json['genre_ids'],
      id: json['id'],
      originalTitle: json['original_title'].toString() ?? "",
      overview: json['overview'].toString() ?? "",
      popularity: json['popularity'],
      posterPath: json['poster_path'].toString() ?? "",
      releaseDate: json['release_date'] ?? '',
      title: json['title'].toString() ?? "",
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
}
