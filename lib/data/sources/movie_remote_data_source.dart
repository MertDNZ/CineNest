import 'dart:convert';
import 'dart:developer';

import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/core/errors/exceptions.dart';
import 'package:cine_nest/data/models/cast_model.dart';
import 'package:cine_nest/data/models/discovery_model.dart';
import 'package:cine_nest/data/models/genre_model.dart';
import 'package:http/http.dart' as http;
import 'package:cine_nest/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMoviesByEndpoints({required String endpoint});
  Future<List<GenreModel>> getGenres();
  Future<DiscoveryModel> getDiscoveryResults({
    required int genreId,
    int? page,
  });
  Future<List<MovieModel>> getSearchedMovies({required String query});
  Future<List<CastModel>> getCasts({required int movieId});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getMoviesByEndpoints(
      {required String endpoint}) async {
    //Request for list of trending movies
    final url = Uri.http(baseUrl, endpoint, queryParameters);
    final response = await http.get(url);
    log(response.statusCode.toString());

    // Checking status code and returning either data or exception
    if (response.statusCode == 200) {
      final data = json.decode(response.body)["results"] as List;
      //log(data.toString());

      return data.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      log('Request failed with status: ${response.statusCode}.');
      throw ServerException();
    }
  }

  @override
  Future<List<GenreModel>> getGenres() async {
    final url = Uri.http(baseUrl, genresEndpoint, queryParameters);
    final response = await http.get(url);
    // log(response.statusCode.toString());

    // Checking status code and returning either data or exception
    if (response.statusCode == 200) {
      final data = json.decode(response.body)["genres"] as List;

      return data.map((e) => GenreModel.fromJson(e)).toList();
      //log(data.toString());
    } else {
      log('Request failed with status: ${response.statusCode}.');
      throw ServerException();
    }
  }

  @override
  Future<DiscoveryModel> getDiscoveryResults({
    required int genreId,
    int? page = 1,
  }) async {
    final Map<String, dynamic> parameters = {
      'with_genres': genreId.toString(),
      'page': page.toString(),
      'sort_by': 'popularity.desc',
    };
    parameters.addAll(queryParameters);

    final uri = Uri.https(baseUrl, discoverEndpoint, parameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return DiscoveryModel.fromJson(data);
    } else {
      // log(response.body);
      log('Request failed with status: ${response.statusCode}.');
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getSearchedMovies({required String query}) async {
    final Map<String, dynamic> parameters = {
      'query': query,
      'sort_by': 'popularity.desc',
    };
    parameters.addAll(queryParameters);
    //Request for list of trending movies
    final url = Uri.http(baseUrl, searchEndpoint, parameters);
    final response = await http.get(url);
    log("searched movies status: ${response.statusCode}");

    // Checking status code and returning either data or exception
    if (response.statusCode == 200) {
      final data = json.decode(response.body)["results"] as List;
      //log(data.toString());

      return data.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      log('Request failed with status: ${response.statusCode}.');
      throw ServerException();
    }
  }

  @override
  Future<List<CastModel>> getCasts({required int movieId}) async {
    final String creditsEndpoint = '$movieId/credits';
    final Uri url =
        Uri.https(baseUrl, movieEndpoint + creditsEndpoint, queryParameters);
    final response = await http.get(url);
    log("cast status: ${response.statusCode}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body)["cast"] as List;
      return data.map((e) => CastModel.fromJson(e)).toList();
    } else {
      log('Request failed with status: ${response.statusCode}.');
      throw ServerException();
    }
  }
}
