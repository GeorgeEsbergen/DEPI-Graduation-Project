import 'package:flutter/material.dart';
import 'package:movie_app/core/constant/colors.dart';

import '../../../../core/constant/fonts.dart';
import '../../../../core/constant/widgets/rating_stars.dart';

class MovieCardDetail extends StatelessWidget {
  const MovieCardDetail({
    super.key,
    required this.imagepath,
    required this.rate,
    required this.genres,
    required this.movieName,
  });

  final String imagepath;
  final String rate;
  final String genres;
  final String movieName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imagepath), fit: BoxFit.cover),
                color: AppColors.w,
                borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                textAlign: TextAlign.start,
                movieName,
                style: AppFontStyle.fontS17W600,
              ),
              const SizedBox(height: 15),
              Text(
                genres,
                style: AppFontStyle.fontS2W600Grey,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  RatingStars(rate: rate),
                  const SizedBox(width: 5),
                  Text(
                    "($rate)",
                    style: AppFontStyle.fontS2W600Grey,
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
