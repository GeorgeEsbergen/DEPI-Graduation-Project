import 'package:flutter/material.dart';

class ChooseChatButton extends StatelessWidget {
  const ChooseChatButton({
    super.key,
    required this.name,
    required this.logo,
    required this.fn,
  });

  final String name;
  final String logo;
  final VoidCallback fn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black.withOpacity(0.1)),
          onPressed: fn,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name),
              const SizedBox(width: 10),
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(logo))),
              )
            ],
          )),
    );
  }
}
