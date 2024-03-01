import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/add_button.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الحساب المصرفي",
        ),
        backgroundColor: ColorsApp.primaryColor,
      ),
      body: Column(children: [
        height16,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextLabel(text: "الحسابات"),
              AddIconButton(
                onPressed: () {},
              ),
            ],
          ),
        ),
        const Divider(),
        const AccountWidget(
          text: "الحساب الأساسي",
          icon: Icons.credit_card,
        ),
        const Divider(indent: 16, endIndent: 16),
        const AccountWidget(
          text: "الحساب الثاني",
          icon: Icons.credit_card,
        ),
        const Divider(indent: 16, endIndent: 16),
      ]),
    );
  }
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16)),
        child: Icon(
          icon,
          color: ColorsApp.primaryColor,
        ),
      ),
      title: Text(text),
    );
  }
}
