import 'package:flutter/material.dart';

class AppColors {
  static const w = Colors.white;
}

BoxDecoration backgroundcolor() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        //Color(0xff49508E),
        Color(0xff16182D),
        Color(0xff222755),
        Color(0xff16182D),
      ],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ),
  );
}
