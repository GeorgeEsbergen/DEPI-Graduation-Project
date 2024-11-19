import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/constant/widgets/back_button.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 380,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imagePath), fit: BoxFit.cover),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: const Center(
                child: Text(""),
              ),
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              height: 320,
              width: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(imagePath), fit: BoxFit.cover),
              ),
            ),
          ),
          BackBtn()
        ],
      ),
    );
  }
}
