import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/core/constant/colors.dart';
import 'package:movie_app/core/constant/fonts.dart';
import 'package:movie_app/features/view/bottm_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


    @override
  void initState() {
    
    getValidation().whenComplete(() async {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(
              context,
              
                  
                   HomePage.routeName));
    });

    super.initState();
  }

  @override
  void dispose() {
    getValidation();
    super.dispose();
  }

  Future getValidation() async {
    
    if (mounted) {
      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: backgroundcolor(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/wlogo.png",
                  width: 100,
                  height: 100,
                ),
                Text(
                  "Filmoria",
                  style: AppFontStyle.fontS20W600,
                )
              ],
            ),
          )),
    );
  }
}
