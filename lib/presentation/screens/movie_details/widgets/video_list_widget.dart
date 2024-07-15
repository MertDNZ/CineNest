import 'package:cine_nest/config/routes/route_constants.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/domain/entities/video_entity.dart';
import 'package:cine_nest/presentation/screens/movie_details/provider/video_provider.dart';
import 'package:cine_nest/presentation/screens/movie_details/widgets/thumbnail_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoListWidget extends StatefulWidget {
  const VideoListWidget({super.key, required this.movieId});
  final int movieId;
  @override
  State<VideoListWidget> createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
  @override
  void initState() {
    super.initState();

    Provider.of<VideoProvider>(context, listen: false)
        .getVideos(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideoProvider>(context);
    final isLoading = provider.isLoading;
    final failure = provider.failure;
    final videoList = provider.videos;

    if (isLoading!) {
      return const SizedBox(
          height: 200, child: Center(child: CircularProgressIndicator()));
    } else if (failure != null) {
      return SizedBox(
        height: 200,
        child: Center(
            child: Text(failure.errorMessage, textAlign: TextAlign.center)),
      );
    } else {
      return _thumbnailListView(videoList);
    }
  }

  Widget _thumbnailListView(List<VideoEntity>? videoList) {
    if (videoList == null || videoList.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            noVideosText,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videoList.length,
        itemBuilder: (BuildContext context, int index) {
          final video = videoList[index];
          return Hero(
            tag: video.key,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, videoPage, arguments: {
                    'videoKey': video.key,
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: ThumbnailWidget(
                    videoKey: video.key,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
