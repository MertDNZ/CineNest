import 'package:cine_nest/core/connection/connection_info.dart';
import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/data/repositories/movie_repository_impl.dart';
import 'package:cine_nest/data/sources/movie_remote_data_source.dart';
import 'package:cine_nest/domain/entities/video_entity.dart';
import 'package:cine_nest/domain/usecases/get_videos.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class VideoProvider extends ChangeNotifier {
  List<VideoEntity>? videos;
  bool? isLoading;
  Failure? failure;

  VideoProvider({this.videos, this.isLoading, this.failure});

  MovieRepositoryImpl repository = MovieRepositoryImpl(
    connectionInfo:
        ConnectionInfoImpl(connectionChecker: InternetConnectionChecker()),
    remoteDataSource: MovieRemoteDataSourceImpl(),
  );

  void getVideos({required int movieId}) async {
    isLoading = true;
    final getVideosOrFailure =
        await GetVideos(repository: repository).call(movieId: movieId);

    getVideosOrFailure.fold((newFailure) {
      failure = newFailure;
      videos = null;
      isLoading = false;
      notifyListeners();
    }, (newVideos) {
      failure = null;
      videos = newVideos.where((video) => video.site == 'YouTube').toList();
      isLoading = false;
      notifyListeners();
    });
  }
}
