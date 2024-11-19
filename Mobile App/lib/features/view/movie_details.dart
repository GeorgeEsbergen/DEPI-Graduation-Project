import 'package:flutter/material.dart';
import 'package:movie_app/core/constant/colors.dart';


import '../../core/constant/fonts.dart';
import '../../testing/movie_recommendations_screen.dart';
import 'widgets/homepage/movie_card.dart';
import 'widgets/movie_details/description_row.dart';
import 'widgets/movie_details/image_card.dart';
import 'widgets/movie_details/name_rating_row.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails(
      {super.key,
      required this.img,
      required this.movieName,
      required this.genre,
      required this.overview,
      required this.rating,
      required this.director,
      required this.cast});
  static String routeName = 'MovieDetails';

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
  final String img;
  final String movieName;
  final String genre;
  final String overview;
  final String rating;
  final String director;
  final String cast;
}

class _MovieDetailsState extends State<MovieDetails> {
  bool _overvieVisible = false;
  bool _castVisible = false;
  bool _directorVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: backgroundcolor(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageCard(
                  imagePath: widget.img,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.movieName,
                    style: AppFontStyle.fontS20W600,
                  ),
                ),
                const SizedBox(height: 10),
                GenresAndRatingRow(
                  genres: widget.genre,
                  rate: widget.rating,
                ),
                const SizedBox(height: 30),
                MovieDescription(
                  isVisible: _overvieVisible,
                  fn: () {
                    setState(() {
                      _overvieVisible = !_overvieVisible;
                    });
                  },
                  name: 'Description',
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Visibility(
                    visible: _overvieVisible,
                    child: Text(
                      widget.overview,
                      style: AppFontStyle.fontS2W600Grey,
                    ),
                  ),
                ),
                MovieDescription(
                  isVisible: _castVisible,
                  fn: () {
                    setState(() {
                      _castVisible = !_castVisible;
                    });
                  },
                  name: 'Cast',
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Visibility(
                    visible: _castVisible,
                    child: Text(
                      widget.cast,
                      style: AppFontStyle.fontS2W600Grey,
                    ),
                  ),
                ),
                MovieDescription(
                  isVisible: _directorVisible,
                  fn: () {
                    setState(() {
                      _directorVisible = !_directorVisible;
                    });
                  },
                  name: 'Director',
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Visibility(
                    visible: _directorVisible,
                    child: Text(
                      "Directed By : ${widget.director}",
                      style: AppFontStyle.fontS2W600Grey,
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Silmilar Movies",
                    style: AppFontStyle.fontS20W600,
                  ),
                ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: double.infinity,
                  height: 270,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MovieRecommendationsScreen(movieTitle:widget.movieName ,)
                                      )
                                      );
                            },
                            child: MovieCard(
                              imagePath: widget.img,
                              movieName: widget.movieName,
                              rate: widget.rating,
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                      itemCount: 3),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
