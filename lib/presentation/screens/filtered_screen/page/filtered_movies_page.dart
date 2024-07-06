import 'package:cine_nest/config/routes/route_constants.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/domain/entities/discovery_entity.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/presentation/common/loading_widget.dart';
import 'package:cine_nest/presentation/common/on_failure_widget.dart';
import 'package:cine_nest/presentation/dialogs/error_dialog.dart';
import 'package:cine_nest/presentation/screens/filtered_screen/provider/filtered_movies_provider.dart';
import 'package:cine_nest/presentation/screens/filtered_screen/widget/custom_movie_card_widget.dart';
import 'package:cine_nest/presentation/screens/home/widgets/poster_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilteredMoviesPage extends StatefulWidget {
  const FilteredMoviesPage({super.key, required this.genre});
  final GenreEntity genre;
  @override
  State<FilteredMoviesPage> createState() => _FilteredMoviesPageState();
}

class _FilteredMoviesPageState extends State<FilteredMoviesPage> {
  late final FilteredMoviesProvider provider;
  late final GenreEntity genre;

  @override
  void initState() {
    super.initState();
    genre = widget.genre;
    provider = Provider.of<FilteredMoviesProvider>(context, listen: false);
    provider.fetchFilteredMovies(genreId: genre.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilteredMoviesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading == true) {
          return const OnLoading();
        } else if (provider.failure != null) {
          return OnFailure(
              failure: provider.failure!,
              onRefresh: () async {
                provider.fetchFilteredMovies(genreId: genre.id);
              });
        } else {
          return _onSuccess(provider.results);
        }
      },
    );
  }

  Widget _onSuccess(DiscoveryEntity? results) {
    bool _hasErrorDialogShown = false;
    void _showErrorDialog() {
      if (!_hasErrorDialogShown) {
        _hasErrorDialogShown = true;
        showErrorDialog(context, imageFailedDialogString);
      }
    }

    if (results == null || results.movie! == [] || results.movie!.isEmpty) {
      return const Center(child: Text('No movies found.'));
    } else {
      final movies = results.movie;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            genre.genre,
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
