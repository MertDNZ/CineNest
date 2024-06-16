import 'dart:convert';
import 'dart:developer';

import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:cine_nest/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMoviesByEndpoints({required String endpoint});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getMoviesByEndpoints(
      {required String endpoint}) async {
    //Request for list of trending movies
    final url = Uri.parse(baseUrl + endpoint)
        .replace(queryParameters: {"api_key": apiKey});
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
}
