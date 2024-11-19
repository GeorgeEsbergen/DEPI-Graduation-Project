import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/core/constant/colors.dart';

class SendMessageTextField extends StatefulWidget {
  const SendMessageTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.validator,
    required this.onSubmitted,
    this.suffixIcon,
  });
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String? Function(String?) onSubmitted;
  final Widget? suffixIcon;

  @override
  State<SendMessageTextField> createState() => _SendMessageTextFieldState();
}

class _SendMessageTextFieldState extends State<SendMessageTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: widget.onSubmitted,
      controller: widget.controller,
      validator: widget.validator,
      cursorColor: Colors.white,
      keyboardType: TextInputType.text,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          suffixIcon: widget.suffixIcon,
          suffixIconColor: Colors.grey),
    );
  }
}

class SearchRow extends StatelessWidget {
  const SearchRow({
    super.key,
    required this.fn,
    required this.controller,
  });
  final VoidCallback fn;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                cursorColor: Colors.white,
                textAlignVertical: TextAlignVertical.top,
                controller: controller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white)),
                  labelText: 'Search',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.w),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: fn,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30)),
              height: 50,
              width: 50,
              child: const Icon(IconlyBold.arrow_right),
            ),
          )
        ],
      ),
    );
  }
}
