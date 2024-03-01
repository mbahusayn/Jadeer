import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/app/split/screens/split_details.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';

class SplitWidget extends StatelessWidget {
  const SplitWidget({
    super.key,
    required this.split,
  });
  final Split split;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SplitDetails(split: split)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16)),
              width: 60,
              height: 60,
              child: const Icon(
                Icons.photo_outlined,
                color: ColorsApp.lightColor,
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                split.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Stack(
                children: [
                  const SizedBox(height: 30, width: 150),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: ColorsApp.lightColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: ColorsApp.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: ColorsApp.lightColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            Row(
              children: [
                TextLabel(text: "${split.totalBalance} ريال"),
                width16,
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
