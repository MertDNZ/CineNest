import 'package:cine_nest/core/connection/connection_info.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/data/repositories/movie_repository_impl.dart';
import 'package:cine_nest/data/sources/movie_remote_data_source.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/domain/usecases/get_top_rated_movies.dart';
import 'package:cine_nest/domain/usecases/get_trend_movies.dart';
import 'package:cine_nest/domain/usecases/get_popular_movies.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomePageProvider extends ChangeNotifier {
  List<MovieEntity>? trendingMovies;
  List<MovieEntity>? popularMovies;
  List<MovieEntity>? topRatedMovies;
  Failure? failure;
  bool? isLoading;

  HomePageProvider({
    this.isLoading,
    this.failure,
    this.trendingMovies,
    this.popularMovies,
    this.topRatedMovies,
  });

  MovieRepositoryImpl repository = MovieRepositoryImpl(
    connectionInfo:
        ConnectionInfoImpl(connectionChecker: InternetConnectionChecker()),
    remoteDataSource: MovieRemoteDataSourceImpl(),
  );

  void fetchMovies() async {
    isLoading = true;
    final trendingMoviesOrFailure =
        await GetTrendingMovies(repository: repository)
            .call(endpoint: trendingMoviesEndpoint);
    trendingMoviesOrFailure.fold((newFailure) {
      trendingMovies = null;
      failure = newFailure;
    }, (newMovies) {
      trendingMovies = newMovies;
      failure = null;
    });

    final popularMoviesOrFailure =
        await GetPopularMovies(repository: repository)
            .call(endpoint: popularMoviesEndpoint);
    popularMoviesOrFailure.fold((newFailure) {
      popularMovies = null;
      failure = newFailure;
    }, (newMovies) {
      popularMovies = newMovies;
      failure = null;
    });

    final topRatedMoviesOrFailure =
        await GetTopRatedMovies(repository: repository)
            .call(endpoint: topRatedMoviesEndpoint);
    topRatedMoviesOrFailure.fold((newFailure) {
      topRatedMovies = null;
      failure = newFailure;
    }, (newMovies) {
      topRatedMovies = newMovies;
      failure = null;
    });

    isLoading = false;
    notifyListeners();
  }
}
