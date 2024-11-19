class Movie {
  final String title;
  final String genre;
  final double rating;

  Movie({required this.title, required this.genre, required this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      genre: json['genre'],
      rating: json['rating'],
    );
  }
}