import 'package:flutter/material.dart';

import '../../../../core/constant/fonts.dart';

class GenresAndRatingRow extends StatelessWidget {
  const GenresAndRatingRow({
    super.key,
    required this.genres,
    required this.rate,
  });

  final String genres;
  final String rate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: Row(
        children: [
          Text(
            genres,
            style: AppFontStyle.fontS17W600,
          ),
          const Spacer(),
          Row(
            children: [
              Image.asset(
                "assets/icons/star.png",
                width: 15,
                height: 15,
              ),
              const SizedBox(width: 5),
              Text(
                rate,
                style: AppFontStyle.fontS2W600Grey,
              ),
              const SizedBox(width: 30)
            ],
          ),
        ],
      ),
    );
  }
}
