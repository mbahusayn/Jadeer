import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  const TextLabel({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({super.key, required this.text, this.color = Colors.black});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
    );
  }
}
