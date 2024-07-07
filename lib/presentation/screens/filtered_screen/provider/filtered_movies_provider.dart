import 'package:cine_nest/core/connection/connection_info.dart';
import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/data/repositories/movie_repository_impl.dart';
import 'package:cine_nest/data/sources/movie_remote_data_source.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/domain/usecases/get_filtered_results.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class FilteredMoviesProvider extends ChangeNotifier {
  int? totalPages;
  int? totalResults;
  List<MovieEntity?>? movies;
  Failure? failure;
  bool? isLoading;
  bool? loadMoreData;

  FilteredMoviesProvider({
    this.totalPages,
    this.totalResults,
    this.movies,
    this.failure,
    this.isLoading,
  });

  MovieRepositoryImpl repository = MovieRepositoryImpl(
    connectionInfo:
        ConnectionInfoImpl(connectionChecker: InternetConnectionChecker()),
    remoteDataSource: MovieRemoteDataSourceImpl(),
  );

  void fetchFilteredMovies({required int genreId, int? page}) async {
    if (page == 1) {
      isLoading = true;
      loadMoreData = false;
      movies = [];
    } else {
      isLoading = false;
      loadMoreData = true;
    }
    final filteredMoviesOrFailure =
        await GetDiscoveryResults.getDiscoveryResults(repository: repository)
            .call(genreId: genreId, page: page);

    filteredMoviesOrFailure.fold((newFailure) {
      totalPages = null;
      totalResults = null;
      failure = newFailure;
      isLoading = false;
      loadMoreData = false;
      notifyListeners();
    }, (newResults) {
      totalPages = newResults.totalPages;
      totalResults = newResults.totalResults;
      movies!.addAll(newResults.movie!.toList());
      failure = null;
      isLoading = false;
      loadMoreData = false;
      notifyListeners();
    });
  }
}
