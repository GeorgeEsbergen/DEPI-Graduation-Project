import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/core/constant/fonts.dart';
import 'package:movie_app/testing/movie.dart';
import 'package:movie_app/testing/movie_card.dart';
import 'package:movie_app/testing/movie_service.dart';

import '../core/constant/colors.dart';

class MovieRecommendationsScreen extends StatefulWidget {
  final String movieTitle;

  MovieRecommendationsScreen({required this.movieTitle});

  @override
  _MovieRecommendationsScreenState createState() =>
      _MovieRecommendationsScreenState();
}

class _MovieRecommendationsScreenState
    extends State<MovieRecommendationsScreen> {
  final MovieService _movieService = MovieService();
  List<Movie> _recommendedMovies = [];

  @override
  void initState() {
    super.initState();
    _fetchRecommendedMovies();
  }

  Future<void> _fetchRecommendedMovies() async {
    final recommendedMovies =
        await _movieService.recommendMovies(widget.movieTitle);
    setState(() {
      _recommendedMovies = recommendedMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: backgroundcolor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Recommended Movies ",
              style: AppFontStyle.fontS20W600,
            ),
            Container(
              height: 500,
              child: Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: _recommendedMovies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(movie: _recommendedMovies[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
