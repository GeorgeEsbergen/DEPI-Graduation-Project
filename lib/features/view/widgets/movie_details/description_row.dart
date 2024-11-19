import 'package:flutter/material.dart';

import '../../../../core/constant/fonts.dart';

class MovieDescription extends StatefulWidget {
  const MovieDescription(
      {super.key, required this.isVisible, required this.fn, required this.name});

  @override
  State<MovieDescription> createState() => _MovieDescriptionState();
  final String name;
  final bool isVisible;
  final VoidCallback fn;
}

class _MovieDescriptionState extends State<MovieDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
           Text(
           widget. name,
            style: AppFontStyle.fontS20W600,
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              widget.isVisible
                  ? Icons.arrow_drop_down_circle_outlined
                  : Icons.arrow_circle_right_outlined,
              size: 30,
            ),
            onPressed: widget.fn,
          ),
        ],
      ),
    );
  }
}
