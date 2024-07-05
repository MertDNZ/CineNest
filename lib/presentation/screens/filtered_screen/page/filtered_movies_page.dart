import 'package:cine_nest/config/routes/routes.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/domain/entities/discovery_entity.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/presentation/common/loading_widget.dart';
import 'package:cine_nest/presentation/common/on_failure_widget.dart';
import 'package:cine_nest/presentation/dialogs/error_dialog.dart';
import 'package:cine_nest/presentation/screens/filtered_screen/provider/filtered_movies_provider.dart';
import 'package:cine_nest/presentation/screens/filtered_screen/widget/custom_movie_card_widet.dart';
import 'package:cine_nest/presentation/screens/home/widgets/poster_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilteredMoviesPage extends StatefulWidget {
  const FilteredMoviesPage({super.key});

  @override
  State<FilteredMoviesPage> createState() => _FilteredMoviesPageState();
}

class _FilteredMoviesPageState extends State<FilteredMoviesPage> {
  @override
  Widget build(BuildContext context) {
    final GenreEntity genre =
        ModalRoute.of(context)!.settings.arguments as GenreEntity;
    final int genreId = genre.id;
    final provider =
        Provider.of<FilteredMoviesProvider>(context, listen: false);
    provider.fetchFilteredMovies(genreId: genreId);

    return Consumer<FilteredMoviesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading == true) {
          return const OnLoading();
        } else if (provider.failure != null) {
          return OnFailure(
              failure: provider.failure!,
              onRefresh: () async {
                provider.fetchFilteredMovies(genreId: genreId);
              });
        } else {
          return _onSuccess(provider.results, genre);
        }
      },
    );
  }

  Widget _onSuccess(DiscoveryEntity? results, GenreEntity genre) {
    final genreText = genre.genre;
    bool _hasErrorDialogShown = false;
    void _showErrorDialog() {
      if (!_hasErrorDialogShown) {
        _hasErrorDialogShown = true;
        showErrorDialog(context, imageFailedDialogString);
      }
    }

    if (results == null || results.movie! == []) {
      return const Center(child: Text('No movies found.'));
    } else {
      final movies = results.movie;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            genreText,
          ),
        ),
        body: ListView.builder(
          itemCount: movies!.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            final image = PosterNetworkImageWidget(
              posterPath: movie!.posterPath,
              onError: _showErrorDialog,
            );

            return Column(
              children: [
                Card(
                  child: InkWell(
                      hoverColor: Colors.white,
                      child: CustomMovieCard(
                        context: context,
                        movie: movie,
                        image: image,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, detailPage, arguments: {
                          'movie': movie,
                          'image': image,
                        });
                      }),
                ),
                const Divider(),
              ],
            );
          },
        ),
      );
    }
  }
}
