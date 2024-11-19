import 'package:flutter/material.dart';
import 'package:movie_app/core/constant/widgets/back_button.dart';
import 'package:movie_app/features/view/widgets/chatbot/send_message.dart';

import '../../../../core/constant/colors.dart';
import 'chatbot.dart';

class OurChatbot extends StatefulWidget {
  static String routeName = 'OurChatbot';

  const OurChatbot({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _OurChatbotState createState() => _OurChatbotState();
}

class _OurChatbotState extends State<OurChatbot> {
  final _textController = TextEditingController();
  final Chatbot _chatbot = Chatbot();
  final List<String> _messages = [];
  final _scrollController = ScrollController(); // Add this line

  void _sendMessage() async {
    final message = _textController.text;
    final response = await _chatbot.sendMessage(message);
    setState(() {
      _messages.add('You: $message');
      _messages.add('Bot: $response');
    });
    _textController.clear();
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundcolor(),
        child: Stack(
          children: [
            _messages.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/wlogo.png",
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "This Chatbot Was Created \n By Filmoria Team",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ))
                : const Text(""),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController, // Add this line
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      bool isUserMessage = _messages[index].startsWith('You:');
                      return Container(
                        margin: isUserMessage
                            ? const EdgeInsets.only(
                                left: 70, right: 10, top: 30)
                            : const EdgeInsets.only(
                                right: 70, left: 10, top: 30),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: isUserMessage
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(isUserMessage ? 50 : 50),
                            bottomLeft: Radius.circular(isUserMessage ? 50 : 0),
                            topRight: Radius.circular(isUserMessage ? 50 : 50),
                            bottomRight:
                                Radius.circular(isUserMessage ? 0 : 50),
                          ),
                        ),
                        child: Text(_messages[index]),
                      );
                    },
                  ),
                ),
                SearchRow(
                  fn: _sendMessage,
                  controller: _textController,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If ChatGPT can make mistakes , ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      "we don't",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
