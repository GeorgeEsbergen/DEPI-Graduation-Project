import 'package:flutter/material.dart';
import 'package:movie_app/features/splash_Screen.dart';
import 'package:movie_app/features/view/chatbott/chatbot/chatui.dart';
import 'package:movie_app/features/view/chatbott/chatbot/omar.dart';

import '../../features/view/bottm_nav_bar.dart';
import '../../features/view/chatbott/gemini/gemini.dart';
import '../../features/view/faq/faq.dart';
import '../../features/view/home_screen.dart';
import '../../testing/movie_recommendations_screen.dart';
import '../../ttt.dart';

class Routess {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) =>  const SplashScreen(), // MovieRecommendationsScreen(movieTitle: 'Tenet'),  // SearchWidget(),
    HomePage.routeName: (context) => HomePage(),

    Faq.routeName: (context) => const Faq(),
    OurChatbot.routeName: (context) => const OurChatbot(),
    GeminiScreen.routeName: (context) => const GeminiScreen(),
  };
}
