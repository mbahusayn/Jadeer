import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.hint,
      required this.controller,
      this.isNumber = false,
      this.isPassword = false});
  final String hint;
  final TextEditingController controller;
  final bool isNumber;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 55,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(FocusNode()),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey[200],
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
