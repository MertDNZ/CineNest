import 'package:cine_nest/config/routes/route_constants.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/main.dart';
import 'package:cine_nest/presentation/screens/filtered_screen/page/filtered_movies_page.dart';
import 'package:cine_nest/presentation/screens/movie_details/page/movie_details_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case defaultPage:
        return MaterialPageRoute(builder: (_) => const Init());
      case detailPage:
        final args = settings.arguments as Map<String, dynamic>;
        final movie = args["movie"] as MovieEntity;
        final image = args["image"] as Widget;
        return MaterialPageRoute(
            builder: (_) => MovieDetailsPage(
                  movie: movie,
                  image: image,
                ));
      case filteredPage:
        final args = settings.arguments as Map<String, dynamic>;
        final genre = args["genre"] as GenreEntity;
        return MaterialPageRoute(
            builder: (_) => FilteredMoviesPage(
                  genre: genre,
                ));
      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) => const RouteError());
}

class RouteError extends StatelessWidget {
  const RouteError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Route Error"),
      ),
    );
  }
}
