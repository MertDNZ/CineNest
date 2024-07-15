import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/domain/entities/video_entity.dart';
import 'package:cine_nest/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetVideos {
  final MovieRepository repository;

  GetVideos({required this.repository});

  Future<Either<Failure, List<VideoEntity>>> call({required int movieId}) {
    return repository.getVideos(movieId: movieId);
  }
}
