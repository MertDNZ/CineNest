import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/core/errors/failure.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/presentation/dialogs/error_dialog.dart';
import 'package:cine_nest/presentation/screens/home/providers/home_page_provider.dart';
import 'package:cine_nest/presentation/screens/home/widgets/custom_listview_widget.dart';
import 'package:cine_nest/presentation/screens/home/widgets/headline_text_widget.dart';
import 'package:cine_nest/presentation/screens/home/widgets/trending_movies_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomePageProvider>(context);
    final failure = provider.failure;
    final isLoading = provider.isLoading;
    final trendingMovies = provider.trendingMovies;
    final popularMovies = provider.popularMovies;
    final topRatedMovies = provider.topRatedMovies;

    // ignore: no_leading_underscores_for_local_identifiers
    Widget _widget;

    if (isLoading!) {
      _widget = const Center(
        child: CircularProgressIndicator(),
      );
      return _widget;
    } else if (failure != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(context, failure.errorMessage);
      });
      _widget = _onFailure(failure);
      return _widget;
    } else {
      _widget =
          _onSuccess(context, trendingMovies, popularMovies, topRatedMovies);
      return _widget;
    }
  }

  Center _onFailure(Failure failure) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(failure.errorMessage),
            TextButton(
              onPressed: _onRefresh,
              child: const Text(refreshButtonString),
            ),
          ]),
    );
  }

  RefreshIndicator _onSuccess(
    BuildContext context,
    List<MovieEntity>? trendingMovies,
    List<MovieEntity>? popularMovies,
    List<MovieEntity>? topRatedMovies,
  ) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            //Trending Movies
            const CustomHeadline(headline: trendingMoviesText, fontSize: 30),
            TrendingMoviesSliderWidget(trendingMovies: trendingMovies),
            const Divider(height: 10, color: Colors.transparent),

            //Popular Movies
            const CustomHeadline(headline: popularMoviesText, fontSize: 25),
            CustomListViewWidget(movieList: popularMovies),
            const Divider(height: 10, color: Colors.transparent),

            //Top Rated Movies
            const CustomHeadline(headline: topRatedMoviesText, fontSize: 25),
            CustomListViewWidget(
              movieList: topRatedMovies,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() {
    Provider.of<HomePageProvider>(context, listen: false).fetchMovies();
    setState(() {});
    return Future.delayed(const Duration(seconds: 0));
  }
}
