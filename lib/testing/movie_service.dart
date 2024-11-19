import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_app/testing/movie.dart';


class MovieService {
  final String _baseUrl = "http://10.0.2.2:5000";

  Future<List<Movie>> recommendMovies(String movieTitle, {String feature = 'overview', int topN = 3}) async {
    final response = await http.get(Uri.parse("$_baseUrl/recommend?movie_title=$movieTitle&feature=$feature&top_n=$topN"));
    final jsonData = jsonDecode(response.body);

    List<Movie> recommendedMovies = [];
    for (var movieJson in jsonData) {
      recommendedMovies.add(Movie.fromJson(movieJson));
    }

    return recommendedMovies;
  }
}