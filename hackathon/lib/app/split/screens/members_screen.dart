import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/add_button.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/app/split/screens/split_screen.dart';
import 'package:hackathon/constants/constants.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key, required this.split});
  final Split split;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(split.title),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextTitle(text: "الأعضاء"),
                AddIconButton(onPressed: () {}),
              ],
            ),
            const Divider(),
            const MemberExpenseWidget(),
            const Divider(),
            const MemberExpenseWidget(),
            const Divider(),
            const MemberExpenseWidget(),
            const Divider()
          ],
        ),
      ),
    );
  }
}

class MemberExpenseWidget extends StatelessWidget {
  const MemberExpenseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration:
                const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          width8,
          Text(user1.name),
        ],
      ),
    );
  }
}
