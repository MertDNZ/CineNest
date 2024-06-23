import 'package:cine_nest/assets/genre_image_dict.dart';
import 'package:cine_nest/core/connection/connection_info.dart';
import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/data/repositories/movie_repository_impl.dart';
import 'package:cine_nest/data/sources/movie_remote_data_source.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/domain/usecases/get_genres.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class DiscoverPageProvider extends ChangeNotifier {
  List<GenreEntity>? genres;
  Failure? failure;
  bool? isLoading;

  DiscoverPageProvider({
    this.genres,
    this.failure,
    this.isLoading,
  });

  MovieRepositoryImpl repository = MovieRepositoryImpl(
    connectionInfo:
        ConnectionInfoImpl(connectionChecker: InternetConnectionChecker()),
    remoteDataSource: MovieRemoteDataSourceImpl(),
  );

  void fetchGenres() async {
    isLoading = true;
    final genresOrFailure = await GetMovieGenres(repository: repository).call();
    genresOrFailure.fold((newFailure) {
      genres = null;
      failure = newFailure;
      isLoading = false;
      notifyListeners();
    }, (fetchedGenres) {
      genres = fetchedGenres;
      failure = null;
      isLoading = false;
      notifyListeners();
    });
  }
}
