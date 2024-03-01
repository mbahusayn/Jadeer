import 'package:flutter/material.dart';
import 'package:hackathon/style/colors.dart';

class AddIconButton extends StatelessWidget {
  const AddIconButton({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
            color: ColorsApp.secondaryColor, shape: BoxShape.circle),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
