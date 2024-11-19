import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/features/view/movie_details.dart';
import 'package:movie_app/features/view/widgets/homepage/movie_card_detail.dart';
import '../../core/constant/colors.dart';
import '../../core/constant/fonts.dart';
import 'widgets/homepage/appbar.dart';
import 'widgets/homepage/movie_card.dart';
import 'widgets/homepage/new_movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _intents = [];
  List limitedDat = [];
  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  _loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/database/ll.json');
    final jsonData = jsonDecode(jsonString);
    setState(() {
      _intents = jsonData['intents'];
    });
    limitedDat = _intents.sublist(90, 100);
  }

  @override
  Widget build(BuildContext context) {
    List limitedData = _intents.take(5).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: backgroundcolor(),
        width: double.infinity,
        padding: const EdgeInsets.only(left: 15, top: 20),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppbar(),
                const SizedBox(height: 30),
                const Text(
                  "Top Movies",
                  style: AppFontStyle.fontS20W600,
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  height: 290,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MovieDetails(
                                        img:
                                            "${limitedDat[index]["cover_url"]}",
                                        movieName:
                                            "${limitedDat[index]["title"]}",
                                        genre:
                                            "${limitedDat[index]["genre"] is String ? limitedDat[index]["genre"] : limitedDat[index]["genre"].join(" , ")}",
                                        overview:
                                            "${limitedDat[index]["overview"].join(" , ")}",
                                        rating:
                                            "${limitedDat[index]["film_rate"]}",
                                        director:
                                            "${limitedDat[index]["director"]}",
                                        cast: limitedDat[index]["cast"]
                                            .join(" , "),
                                      )));
                            },
                            child: MovieCard(
                              imagePath: "${limitedDat[index]["cover_url"]}",
                              movieName: "${limitedDat[index]["title"]}",
                              rate: "${limitedDat[index]["film_rate"]}",
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                      itemCount: limitedDat.length),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Movies 2024",
                  style: AppFontStyle.fontS20W600,
                ),
                const SizedBox(height: 35),
                const NewMovies(),
                const SizedBox(height: 40),
                const Text(
                  "Others Movies",
                  style: AppFontStyle.fontS20W600,
                ),
                const SizedBox(height: 35),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                      img: "${limitedData[index]["cover_url"]}",
                                      movieName:
                                          "${limitedData[index]["title"]}",
                                      genre:
                                          "${limitedData[index]["genre"] is String ? limitedData[index]["genre"] : limitedData[index]["genre"].join(" , ")}",
                                      overview:
                                          "${limitedData[index]["overview"].join(" , ")}",
                                      rating:
                                          "${limitedData[index]["film_rate"]}",
                                      director:
                                          "${limitedData[index]["director"]}",
                                      cast: limitedData[index]["cast"]
                                          .join(" , "),
                                    )));
                          },
                          child: MovieCardDetail(
                            imagepath: "${limitedData[index]["cover_url"]}",
                            genres:
                                "${limitedData[index]["genre"] is String ? limitedData[index]["genre"] : limitedData[index]["genre"].join(" , ")}",
                            rate: "${limitedData[index]["film_rate"]}",
                            movieName: "${limitedData[index]["title"]}",
                          ),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                    itemCount: limitedData.length),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
