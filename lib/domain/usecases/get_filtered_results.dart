import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/domain/entities/discovery_entity.dart';
import 'package:cine_nest/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetDiscoveryResults {
  final MovieRepository repository;

  GetDiscoveryResults({required this.repository});

  Future<Either<Failure, DiscoveryEntity>> call(
      {required int genreId, int? page}) {
    return repository.getDiscoveryResults(genreId = genreId, page = page);
  }
}
