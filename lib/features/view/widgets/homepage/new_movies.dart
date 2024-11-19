import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

List<String>? items = [
  "assets/images/posters/n1.jpeg",
  "assets/images/posters/n2.jpg",
  "assets/images/posters/n3.jpg",
  "assets/images/posters/n4.jpg",
];

class NewMovies extends StatefulWidget {
  const NewMovies({super.key});

  @override
  State<NewMovies> createState() => _NewMoviesState();
}

class _NewMoviesState extends State<NewMovies> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: items!.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              height: 120,
              width: 300,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey,
                  image:
                      DecorationImage(image: AssetImage(i), fit: BoxFit.fill)),
            );
          },
        );
      }).toList(),
    );
  }
}
