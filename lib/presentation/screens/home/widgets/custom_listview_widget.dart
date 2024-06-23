import 'package:cine_nest/config/routes/routes.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/presentation/dialogs/error_dialog.dart';
import 'package:cine_nest/presentation/screens/home/widgets/poster_image_widget.dart';
import 'package:flutter/material.dart';

class CustomListViewWidget extends StatelessWidget {
  const CustomListViewWidget({super.key, required this.movieList});
  final List<MovieEntity>? movieList;

  @override
  Widget build(BuildContext context) {
    bool _hasErrorDialogShown = false;

    void _showErrorDialog() {
      if (!_hasErrorDialogShown) {
        _hasErrorDialogShown = true;
        showErrorDialog(context, imageFailedDialogString);
      }
    }

    return SizedBox(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieList!.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = movieList![index];
          final posterPath = movie.posterPath;
          final image = PosterNetworkImageWidget(
            posterPath: posterPath,
            onError: _showErrorDialog,
          );
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, detailScreen, arguments: {
                  'movie': movie,
                  'image': image,
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: image,
              ),
            ),
          );
        },
      ),
    );
  }
}
