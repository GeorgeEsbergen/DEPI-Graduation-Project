import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 30,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(IconlyBold.arrow_left),
        ),
      ),
    );
  }
}
