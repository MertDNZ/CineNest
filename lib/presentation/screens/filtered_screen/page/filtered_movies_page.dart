import 'package:cine_nest/config/routes/route_constants.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
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
  int page = 1;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    genre = widget.genre;
    provider = Provider.of<FilteredMoviesProvider>(context, listen: false);
    provider.fetchFilteredMovies(genreId: genre.id, page: page);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadMoreData();
  }

  void _loadMoreData() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        page++;
        provider.fetchFilteredMovies(genreId: genre.id, page: page);
      }
    });
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
          List<MovieEntity?>? movies = provider.movies;
          return _onSuccess(movies, scrollController);
        }
      },
    );
  }

  Widget _onSuccess(
      List<MovieEntity?>? movies, ScrollController scrollController) {
    bool _hasErrorDialogShown = false;
    void _showErrorDialog() {
      if (!_hasErrorDialogShown) {
        _hasErrorDialogShown = true;
        showErrorDialog(context, imageFailedDialogString);
      }
    }

    if (movies == [] || movies!.isEmpty) {
      return const Center(child: Text('No movies found.'));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            genre.genre,
          ),
        ),
        body: ListView.builder(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: false,
          itemCount: movies!.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == movies.length) {
              return const SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(child: CircularProgressIndicator()));
            } else {
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
            }
          },
        ),
      );
    }
  }
}
