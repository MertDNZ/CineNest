import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/domain/entities/cast_entity.dart';
import 'package:cine_nest/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetCasts {
  final MovieRepository repository;
  GetCasts({required this.repository});
  Future<Either<Failure, List<CastEntity>>> call({required int movieId}) {
    return repository.getCasts(movieId: movieId);
  }
}
