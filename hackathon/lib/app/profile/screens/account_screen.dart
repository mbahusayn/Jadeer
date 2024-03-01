import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/profile/widgets/profile_tile.dart';
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
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: ColorsApp.secondaryColor, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const ProfileTile(
          text: "الحساب الأساسي",
          icon: Icons.credit_card,
          screen: AccountScreen(),
        ),
        const Divider(indent: 16, endIndent: 16),
        const ProfileTile(
          text: "الحساب الثاني",
          icon: Icons.credit_card,
          screen: AccountScreen(),
        ),
        const Divider(indent: 16, endIndent: 16),
      ]),
    );
  }
}
