import 'package:cine_nest/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

class CustomMovieCard extends StatelessWidget {
  const CustomMovieCard({
    super.key,
    required this.context,
    required this.movie,
    required this.image,
  });

  final BuildContext context;
  final MovieEntity? movie;
  final Widget image;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: image,
              ),
            ),
            Positioned(
              right: 3,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    movie!.voteAverage.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                movie!.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                movie!.releaseDate,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                movie!.overview,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
