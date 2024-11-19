import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/features/view/faq/faq.dart';

import '../../../../core/constant/fonts.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset(
          "assets/icons/wlogo.png",
          width: 25,
          height: 25,
        ),
        const Text(
          "Filmoria",
          style: AppFontStyle.fontS20W60,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(Faq.routeName);
          },
          child: Image.asset(
            "assets/icons/about.png",
            width: 20,
            height: 20,
          ),
        ),
      ]),
    );
  }
}
