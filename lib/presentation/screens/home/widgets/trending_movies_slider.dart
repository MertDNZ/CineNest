import 'package:carousel_slider/carousel_slider.dart';
import 'package:cine_nest/config/routes/routes.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/presentation/dialogs/error_dialog.dart';
import 'package:cine_nest/presentation/screens/home/widgets/poster_image_widget.dart';
import 'package:flutter/material.dart';

class TrendingMoviesSliderWidget extends StatelessWidget {
  const TrendingMoviesSliderWidget({super.key, required this.trendingMovies});
  final List<MovieEntity>? trendingMovies;

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
      width: double.infinity,
      child: CarouselSlider.builder(
        options: CarouselOptions(
            height: 350,
            autoPlay: true,
            viewportFraction: 0.55,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 1)),
        itemCount: trendingMovies!.length,
        itemBuilder: (context, index, realIndex) {
          final movie = trendingMovies![index];
          final posterPath = movie.posterPath;
          Widget image = PosterNetworkImageWidget(
            posterPath: posterPath,
            onError: _showErrorDialog,
          );
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, detailScreen, arguments: {
                'movie': movie,
                'image': image,
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: image,
            ),
          );
        },
      ),
    );
  }
}
