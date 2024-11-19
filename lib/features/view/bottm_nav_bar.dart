import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/features/view/search_screen.dart';

import 'chatbott/chat_screen.dart';
import 'home_screen.dart';


class HomePage extends StatefulWidget {

  
  static const String routeName = " BottmNav";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List pages = <Widget>[
    const HomeScreen(),
    SearchWidget(),
    //const SearchWidget(),
    const ChatScreen(),
  ];

  int selectedItem = 0;

  void selectedPage(int val) {
    setState(() {
      selectedItem = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[selectedItem],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(

          currentIndex: selectedItem,
          height: 10,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          onTap: selectedPage,
          items: [
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
                icon: IconlyBold.search,
                unselectedIcon: IconlyLight.search,
                selectedColor: Colors.white),
            CrystalNavigationBarItem(
              icon: IconlyBold.chat,
              unselectedIcon: IconlyBold.chat,
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
