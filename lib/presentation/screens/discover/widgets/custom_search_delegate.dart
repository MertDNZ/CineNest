import 'package:cine_nest/config/routes/route_constants.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/presentation/screens/discover/providers/discover_page_provider.dart';
import 'package:cine_nest/presentation/screens/home/widgets/poster_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  final DiscoverPageProvider provider;
  CustomSearchDelegate({
    super.searchFieldLabel,
    super.searchFieldStyle,
    super.searchFieldDecorationTheme,
    super.keyboardType,
    super.textInputAction,
    required this.provider,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Search Movies
    Provider.of<DiscoverPageProvider>(context, listen: false)
        .fetchSearchResults(query: query);

    bool _isClosed = false;
    void _onError() {
      if (!_isClosed) {
        _isClosed = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          close(context, null);
        });
      }
    }

    if (provider.failure != null) {
      _onError();
      return Container();
    } else {
      return Consumer<DiscoverPageProvider>(
          builder: (context, provider, child) {
        if (query.isEmpty) {
          return Container();
        }

        if (provider.searchesLoading!) {
          return const Center(child: CircularProgressIndicator());
        }

        List<MovieEntity?>? results = provider.searchedMovies;
        if (results == null || results.isEmpty) {
          Future.delayed(const Duration(seconds: 2));
          return const Center(child: Text('No suggestions found.'));
        } else {
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (BuildContext context, int index) {
              final movie = results[index];
              final _image = PosterNetworkImageWidget(
                posterPath: movie!.posterPath,
                onError: _onError,
              );

              return ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.releaseDate.toString()),
                leading: SizedBox(
                  width: 50,
                  height: 200,
                  child: _image,
                ),
                onTap: () {
                  Navigator.pushNamed(context, detailPage, arguments: {
                    'movie': movie,
                    'image': _image,
                  });
                },
              );
            },
          );
        }
      });
    }
  }
}
