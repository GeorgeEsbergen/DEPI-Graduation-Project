import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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
  List<dynamic> _searchResults = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> _fetchMoviesFromTMDB(String query) async {
    final apiKey = 'ddad317e776c8ec2f92ec52efe9d34f5';
    final url =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  _searchIntents(String query) async {
    final results = await _fetchMoviesFromTMDB(query);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundcolor(),
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
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
            _searchResults.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = _searchResults[index];
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MovieDetails(
                                    genre: movie['genre_ids'].join(', '),
                                    img:
                                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                    movieName: movie['title'],
                                    overview: movie['overview'],
                                    rating: movie['vote_average'].toString(),
                                    director:
                                        '', // Not available in TMDB search results
                                    cast:
                                        '', // Not available in TMDB search results
                                  )));
                        },
                        leading: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
                        title: Text(
                          movie['title'],
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          movie['genre_ids'].join(', '),
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
                                movie['vote_average'].toString(),
                                style: AppFontStyle.fontS2W600Grey,
                              ),
                              const SizedBox(width: 30)
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Text('No match found'),
          ],
        ),
      ),
    );
  }
}
