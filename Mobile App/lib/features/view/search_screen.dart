// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/core/constant/colors.dart';
import 'package:movie_app/core/constant/fonts.dart';
import 'package:movie_app/features/view/movie_details.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _intents = [];
  String _searchResult = '';
  String title = '';
  String imagePath = '';
  String rate = '';
  String overview = '';
  String director = '';
  String cast = '';

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
  }

  _searchIntents(String query) {
    for (var intent in _intents) {
      if (intent['title'].toLowerCase().contains(query.toLowerCase())) {
        setState(() {
          _searchResult = intent['genre'].join(" , ");
          title = intent['title'];
          imagePath = intent['cover_url'];
          rate = intent['film_rate'];
          overview = intent['overview'].join(" , ");
          director = intent['director'];
          cast = intent['cast'].join(" , ");

          // resp = intent['responses'][0];
        });
        return;
      }
    }
    setState(() {
      _searchResult = 'No match found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundcolor(),
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 150),
            const Text(
              "Search for movies by movie name ",
              style: AppFontStyle.fontS17W600,
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                onSubmitted: (value) {
                  final query = _searchController.text;
                  _searchIntents(query);
                },
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      final query = _searchController.text;
                      _searchIntents(query);
                    },
                  ),
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.w),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.w),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _searchResult != ''
                ? ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieDetails(
                                genre: _searchResult,
                                img: imagePath,
                                movieName: title,
                                overview: overview,
                                rating: rate,
                                director: director,
                                cast: cast,
                              )));
                    },
                    leading: Image.network(
                        imagePath), // Replace with actual image asset
                    title: SizedBox(
                      width: 100,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Text(
                      _searchResult,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Container(
                      width: 80,
                      child: Row(
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
                    ), // Display the response text
                  )
                : Text(_searchResult),
          ],
        ),
      ),
    );
  }
}
