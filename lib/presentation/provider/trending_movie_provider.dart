import 'package:cine_nest/core/connection/connection_info.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/data/repositories/movie_repository_impl.dart';
import 'package:cine_nest/data/sources/movie_remote_data_source.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/domain/usecases/get_movies_by_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class TrendingMoviesProvider extends ChangeNotifier {
  List<MovieEntity>? trendingMovies;
  List<MovieEntity>? popularMovies;
  Failure? failure;

  TrendingMoviesProvider({
    this.trendingMovies,
    this.popularMovies,
    this.failure,
  });

  MovieRepositoryImpl repository = MovieRepositoryImpl(
    connectionInfo:
        ConnectionInfoImpl(connectionChecker: InternetConnectionChecker()),
    remoteDataSource: MovieRemoteDataSourceImpl(),
  );

  void eitherMovieOrFailureMain() async {
    final trendingMoviesOrFailure =
        await GetTrendingMovies(repository: repository)
            .call(endpoint: trendingMoviesEndpoint);
    trendingMoviesOrFailure.fold((newFailure) {
      trendingMovies = null;
      failure = newFailure;
      notifyListeners();
    }, (newMovies) {
      trendingMovies = newMovies;
      failure = null;
      notifyListeners();
    });

    final popularMoviesOrFailure =
        await GetPopularMovies(repository: repository)
            .call(endpoint: popularMoviesEndpoint);
    popularMoviesOrFailure.fold((newFailure) {
      popularMovies = null;
      failure = newFailure;
      notifyListeners();
    }, (newMovies) {
      popularMovies = newMovies;
      failure = null;
      notifyListeners();
    });
  }
}
