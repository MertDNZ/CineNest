import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:flutter/material.dart';

class PosterNetworkImageWidget extends StatelessWidget {
  const PosterNetworkImageWidget(
      {super.key, required this.posterPath, this.onError = _defaultOnError});
  final String posterPath;
  final VoidCallback onError;
  static void _defaultOnError() {}
  @override
  Widget build(BuildContext context) {
    // return posterPath == "null"
    //     ? _default()
    //     : Image.network(posterUrl + posterPath, fit: BoxFit.cover,
    //         errorBuilder: (context, error, stackTrace) {
    //         WidgetsBinding.instance.addPostFrameCallback((_) {
    //           onError();
    //         });
    //         return _default();
    //       });
    return posterPath == "null"
        ? _default()
        : CachedNetworkImage(
            imageUrl: posterUrl + posterPath,
            errorWidget: (context, url, error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                onError();
              });
              return _default();
            },
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              if (downloadProgress.progress != null) {
                return Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
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
            });
  }

  Container _default() {
    return Container(
      color: Colors.grey,
      child: const Center(
        child: Icon(
          Icons.movie,
        ),
      ),
    );
  }
}
