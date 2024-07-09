import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:cine_nest/presentation/screens/movie_detail/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movie, required this.image});
  final MovieEntity movie;
  final Widget image;
  @override
  Widget build(BuildContext context) {
    final parseDate = DateFormat('yyyy-MM-dd').parse(movie.releaseDate);
    final date = DateFormat('MM/yyyy').format(parseDate).toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Details"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: image,
              ),
            ),
          ),
          Column(
            children: [
              CustomTextWidget(
                text: movie.title,
                fontSize: 30,
              ),
              const Divider(),
              CustomTextWidget(
                text: releaseDateText + date,
              ),
              CustomTextWidget(
                text: popularityText + movie.voteAverage.toStringAsFixed(1),
              ),
              CustomTextWidget(
                text: totalVoteText + movie.voteCount.toString(),
              ),
              const Divider(),
              CustomTextWidget(
                text: movie.overview,
                fontSize: 20,
                padding: 8,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
