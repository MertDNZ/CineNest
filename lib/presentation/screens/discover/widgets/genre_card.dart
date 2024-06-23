import 'package:cine_nest/assets/genre_image_dict.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:flutter/material.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({
    super.key,
    required this.genre,
  });
  final GenreEntity genre;

  @override
  Widget build(BuildContext context) {
    final imagePath = _imagePath(genre: genre);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black54,
            child: Center(
              child: Text(
                genre.genre,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _imagePath({required GenreEntity genre}) {
    final String genreString = genre.genre;
    for (var map in genreList) {
      if (map["title"] == genreString) {
        return map["image"] ?? defaultImagePath;
      }
    }
    return defaultImagePath;
  }
}
