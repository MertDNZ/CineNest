import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMoviesByEndpoints({
    required String endpoint,
  });

  Future<Either<Failure, List<GenreEntity>>> getGenres();
}
