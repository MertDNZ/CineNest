import 'dart:developer';

import 'package:cine_nest/core/connection/connection_info.dart';
import 'package:cine_nest/core/errors/exceptions.dart';
import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/data/sources/movie_remote_data_source.dart';
import 'package:cine_nest/domain/entities/cast_entity.dart';
import 'package:cine_nest/domain/entities/discovery_entity.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/domain/entities/video_entity.dart';
import 'package:cine_nest/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final ConnectionInfo connectionInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionInfo,
  });
  @override
  Future<Either<Failure, List<MovieEntity>>> getMoviesByEndpoints(
      {required String endpoint}) async {
    if (await connectionInfo.isConnected!) {
      try {
        final movies =
            await remoteDataSource.getMoviesByEndpoints(endpoint: endpoint);
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server Exception'));
      } catch (_) {
        return Left(ServerFailure(errorMessage: 'Something Went Wrong'));
      }
    } else {
      return Left(NetworkFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<GenreEntity>>> getGenres() async {
    if (await connectionInfo.isConnected!) {
      try {
        final genres = await remoteDataSource.getGenres();
        return Right(genres);
      } on ServerException {
        return Left(ServerFailure(errorMessage: "Server Exception"));
      } catch (_) {
        return Left(ServerFailure(errorMessage: 'Something Went Wrong'));
      }
    } else {
      return Left(NetworkFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, DiscoveryEntity>> getDiscoveryResults(
      int genreId, int? page) async {
    if (await connectionInfo.isConnected!) {
      try {
        final discoveryResults = await remoteDataSource.getDiscoveryResults(
            genreId: genreId, page: page);
        return Right(discoveryResults);
      } on ServerException {
        return Left(ServerFailure(errorMessage: "Server Exception"));
      } catch (_) {
        log(_.toString());
        return Left(ServerFailure(errorMessage: 'Something Went Wrong'));
      }
    } else {
      return Left(NetworkFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getSearchedMovies(
      {required String query}) async {
    if (await connectionInfo.isConnected!) {
      try {
        final movies = await remoteDataSource.getSearchedMovies(query: query);
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server Exception'));
      } catch (_) {
        return Left(ServerFailure(errorMessage: 'Something Went Wrong'));
      }
    } else {
      return Left(NetworkFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<CastEntity>>> getCasts(
      {required int movieId}) async {
    if (await connectionInfo.isConnected!) {
      try {
        final casts = await remoteDataSource.getCasts(movieId: movieId);
        return Right(casts);
      } on ServerException {
        return Left(ServerFailure(errorMessage: "Server Exception"));
      } catch (_) {
        return Left(ServerFailure(errorMessage: "Something went wrong"));
      }
    } else {
      return Left(NetworkFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getVideos(
      {required int movieId}) async {
    if (await connectionInfo.isConnected!) {
      try {
        final videos = await remoteDataSource.getVideos(movieId: movieId);
        return Right(videos);
      } on ServerException {
        return Left(ServerFailure(errorMessage: "Server Exception"));
      } catch (_) {
        return Left(ServerFailure(errorMessage: 'Something Went Wrong'));
      }
    } else {
      return Left(NetworkFailure(errorMessage: 'No internet connection'));
    }
  }
}
