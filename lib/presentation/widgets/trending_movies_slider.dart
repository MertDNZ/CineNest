import 'package:carousel_slider/carousel_slider.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/presentation/dialogs/error_dialog.dart';
import 'package:cine_nest/presentation/provider/trending_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingMoviesSliderWidget extends StatelessWidget {
  const TrendingMoviesSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TrendingMoviesProvider>(context);
    final trendingMovies = provider.trendingMovies;
    final failure = provider.failure;

    if (failure != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(context, failure.errorMessage);
      });
      return Center(
        child: Text(failure.errorMessage),
      );
    } else if (trendingMovies != null) {
      return _trendingMovieSlider(trendingMovies);
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  SizedBox _trendingMovieSlider(List<MovieEntity>? trendingMovies) {
    bool _hasErrorDialogShown = false;
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        options: CarouselOptions(
            height: 300,
            autoPlay: true,
            viewportFraction: 0.55,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 1)),
        itemCount: trendingMovies!.length,
        itemBuilder: (context, index, realIndex) {
          final movie = trendingMovies[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/second',
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 300,
                width: 200,
                color: Theme.of(context).colorScheme.secondary,
                child: Image.network(posterUrl + movie.posterPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!_hasErrorDialogShown) {
                      _hasErrorDialogShown = true;
                      showErrorDialog(context, 'Failed to load image');
                    }
                  });
                  return Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.black,
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
