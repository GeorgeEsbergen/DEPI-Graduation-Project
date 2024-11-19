import 'package:flutter/material.dart';
import 'package:movie_app/testing/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie? movie;

  MovieCard({this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.withOpacity(0.1),
      child: Column(
        children: [
          Text(movie?.title ?? ''),
          Text(movie?.genre ?? ''),
          Text(movie?.rating.toString() ?? ''),
        ],
      ),
    );
  }
}
