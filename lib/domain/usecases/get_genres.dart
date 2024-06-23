import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetMovieGenres {
  final MovieRepository repository;

  GetMovieGenres({required this.repository});

  Future<Either<Failure, List<GenreEntity>>> call() {
    return repository.getGenres();
  }
}
