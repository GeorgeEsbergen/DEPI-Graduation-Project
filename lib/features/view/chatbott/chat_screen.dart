import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/features/view/chatbott/gemini/gemini.dart';

import '../../../core/constant/colors.dart';
import '../widgets/chatbot/choosebot_botton.dart';
import 'chatbot/chatui.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: backgroundcolor(),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChooseChatButton(
              name: 'Our Chatbot',
              logo: "assets/icons/blogo.png",
              fn: () {
                Navigator.of(context).pushNamed(OurChatbot.routeName);
              },
            ),
            const SizedBox(height: 50),
            ChooseChatButton(
              name: 'Gemini',
              logo: "assets/icons/gemini.png",
              fn: () {
                Navigator.of(context).pushNamed(GeminiScreen.routeName);
              },
            ),
          ],
        ));
  }
}
