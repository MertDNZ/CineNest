import 'package:cine_nest/domain/entities/genre_entity.dart';

class GenreModel extends GenreEntity {
  GenreModel({
    required super.id,
    required super.genre,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json['id'],
        genre: json['name'],
      );
}
