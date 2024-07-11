import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/domain/entities/cast_entity.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/domain/entities/discovery_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMoviesByEndpoints({
    required String endpoint,
  });

  Future<Either<Failure, DiscoveryEntity>> getDiscoveryResults(
    int genreId,
    int? page,
  );

  Future<Either<Failure, List<MovieEntity>>> getSearchedMovies({
    required String query,
  });

  Future<Either<Failure, List<GenreEntity>>> getGenres();

  Future<Either<Failure, List<CastEntity>>> getCasts({
    required int movieId,
  });
}
