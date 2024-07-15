import 'package:cine_nest/core/connection/connection_info.dart';
import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/data/repositories/movie_repository_impl.dart';
import 'package:cine_nest/data/sources/movie_remote_data_source.dart';
import 'package:cine_nest/domain/entities/cast_entity.dart';
import 'package:cine_nest/domain/usecases/get_casts.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CastProvider extends ChangeNotifier {
  List<CastEntity>? casts;
  Failure? failure;
  bool? isLoading;
  String? videoUrl;

  CastProvider({
    this.casts,
    this.failure,
    this.isLoading,
  });

  MovieRepositoryImpl repository = MovieRepositoryImpl(
    connectionInfo:
        ConnectionInfoImpl(connectionChecker: InternetConnectionChecker()),
    remoteDataSource: MovieRemoteDataSourceImpl(),
  );

  void getCasts({required int movieId}) async {
    isLoading = true;
    final getCastsOrFailure =
        await GetCasts(repository: repository).call(movieId: movieId);

    getCastsOrFailure.fold((newFailure) {
      casts = null;
      failure = newFailure;
      isLoading = false;
      notifyListeners();
    }, (newResults) {
      casts = newResults;
      failure = null;
      isLoading = false;
      notifyListeners();
    });
  }
}
