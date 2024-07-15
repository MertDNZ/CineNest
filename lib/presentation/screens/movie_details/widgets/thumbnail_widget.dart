import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ThumbnailWidget extends StatelessWidget {
  const ThumbnailWidget({
    super.key,
    required this.videoKey,
  });
  final String videoKey;
  static void _defaultOnError() {}
  @override
  Widget build(BuildContext context) {
    return videoKey == "null" || videoKey.isEmpty
        ? _default()
        : CachedNetworkImage(
            imageUrl: "https://img.youtube.com/vi/$videoKey/0.jpg",
            errorWidget: (context, url, error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _defaultOnError();
              });
              return _default();
            },
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              if (downloadProgress.progress != null) {
                return SizedBox(
                  width: 200,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
            imageBuilder: (context, imageProvider) {
              return Stack(
                children: [
                  Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                  )
                ],
              );
            },
          );
  }

  Container _default() {
    return Container(
      height: 300,
      color: Colors.black54,
      child: const Center(
        child: Icon(
          Icons.movie,
        ),
      ),
    );
  }
}
