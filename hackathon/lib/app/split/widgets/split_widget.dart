import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/app/split/screens/split_details/split_details.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 10),
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
                size: 40,
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                split.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              height8,
              Stack(
                children: [
                  const SizedBox(height: 30, width: 150),
                  for (var i = 0; i < split.members.length; i++)
                    Positioned(
                      right: i * 20,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: i % 2 != 0
                              ? ColorsApp.lightColor
                              : ColorsApp.primaryColor,
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
