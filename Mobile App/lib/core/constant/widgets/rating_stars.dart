import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconly/iconly.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rate,
  });

  final String rate;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 20,
      initialRating: double.parse(rate) / 2,
      minRating: 1,
      maxRating: 20,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      itemBuilder: (context, _) => const Icon(
        IconlyBold.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
