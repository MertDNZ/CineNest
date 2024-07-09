import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetSearchedMovies {
  final MovieRepository repository;

  GetSearchedMovies({required this.repository});

  Future<Either<Failure, List<MovieEntity>>> call({required String query}) {
    return repository.getSearchedMovies(query: query);
  }
}
