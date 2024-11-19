import 'package:flutter/material.dart';
import 'package:movie_app/core/constant/fonts.dart';
import 'package:movie_app/core/constant/widgets/rating_stars.dart';
import '../../../../core/constant/colors.dart';
import '../../../../testing/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie? movie;
  const MovieCard({
    super.key,
    required this.imagePath,
    required this.movieName,
    required this.rate, this.movie,
  });
  final String imagePath;
  final String movieName;
  final String rate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 170,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imagePath), fit: BoxFit.cover),
              color: AppColors.w,
              borderRadius: BorderRadius.circular(30)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 180,
          child: Text(
            textAlign: TextAlign.center,
            movieName,
            style: AppFontStyle.fontS17W600,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 5),
        RatingStars(rate: rate),
      ],
    );
  }
}
