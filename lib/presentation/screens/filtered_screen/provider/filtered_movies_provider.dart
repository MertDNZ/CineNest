import 'package:cine_nest/core/connection/connection_info.dart';
import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/data/repositories/movie_repository_impl.dart';
import 'package:cine_nest/data/sources/movie_remote_data_source.dart';
import 'package:cine_nest/domain/entities/discovery_entity.dart';
import 'package:cine_nest/domain/usecases/get_filtered_results.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class FilteredMoviesProvider extends ChangeNotifier {
  DiscoveryEntity? results;
  Failure? failure;
  bool? isLoading;

  FilteredMoviesProvider({
    this.results,
    this.failure,
    this.isLoading,
  });

  MovieRepositoryImpl repository = MovieRepositoryImpl(
    connectionInfo:
        ConnectionInfoImpl(connectionChecker: InternetConnectionChecker()),
    remoteDataSource: MovieRemoteDataSourceImpl(),
  );

  void fetchFilteredMovies({required int genreId}) async {
    isLoading = true;
    final filteredMoviesOrFailure =
        await GetDiscoveryResults.getDiscoveryResults(repository: repository)
            .call(genreId: genreId);

    filteredMoviesOrFailure.fold((newFailure) {
      results = null;
      failure = newFailure;
      isLoading = false;
      notifyListeners();
    }, (newResults) {
      results = newResults;
      failure = null;
      isLoading = false;
      notifyListeners();
    });
  }
}
