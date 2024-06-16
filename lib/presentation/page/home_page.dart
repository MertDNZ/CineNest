import 'package:cine_nest/presentation/widgets/trending_movies_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        trendingMovieText(),
        const TrendingMoviesSliderWidget(),
      ],
    );
  }

  Row trendingMovieText() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
          child: Text(
            "Trending Movies",
            style: TextStyle(fontSize: 30),
          ),
        )
      ],
    );
  }
}
