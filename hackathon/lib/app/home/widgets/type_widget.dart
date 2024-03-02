import 'package:flutter/material.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget({
    super.key,
    required this.type,
    required this.amount,
  });
  final String type;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context) * 0.4,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: type == "النفقات" ? Colors.red[300] : ColorsApp.primaryColor,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                type,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              width32,
              Icon(
                type == "النفقات"
                    ? Icons.arrow_circle_up
                    : Icons.arrow_circle_down,
                color: Colors.white,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                amount.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const Text(
                " ريال ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
