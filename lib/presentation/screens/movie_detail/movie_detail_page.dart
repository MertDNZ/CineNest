import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/presentation/screens/movie_detail/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final movie = args["movie"] as MovieEntity;
    final image = args["image"] as Widget;
    final parseDate = DateFormat('yyyy-MM-dd').parse(movie.releaseDate);
    final date = DateFormat('MM/yyyy').format(parseDate).toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Details"),
      ),
      body: Column(children: [
        Row(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 300,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: image),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                CustomTextWidget(
                  text: movie.title,
                  fontSize: 30,
                ),
                const Divider(),
                CustomTextWidget(text: "Release Date: $date"),
                CustomTextWidget(
                    text:
                        "Popularity: ${movie.voteAverage.toStringAsFixed(1)}"),
                CustomTextWidget(
                    text: "Total Vote: ${movie.voteCount.toString()}"),
              ],
            ),
          ),
        ]),
        const Divider(),
        CustomTextWidget(
          text: movie.overview,
          fontSize: 20,
          padding: 8,
        )
      ]),
    );
  }
}
