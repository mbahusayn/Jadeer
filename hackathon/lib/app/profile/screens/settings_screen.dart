import 'package:flutter/material.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الإعدادات",
        ),
        backgroundColor: ColorsApp.primaryColor,
      ),
      body: Column(children: [
        height16,
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16)),
            child: const Icon(
              Icons.dark_mode_outlined,
              color: ColorsApp.primaryColor,
            ),
          ),
          title: const Text("المظهر الداكن"),
          trailing: Switch.adaptive(
            value: false,
            onChanged: (value) {},
            activeColor: ColorsApp.secondaryColor,
          ),
        ),
        const Divider(),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16)),
            child: const Text("ع",
                style: TextStyle(
                    color: ColorsApp.primaryColor,
                    fontWeight: FontWeight.bold)),
          ),
          title: const Text("اللغة العربية"),
          trailing: Switch.adaptive(
            value: true,
            onChanged: (value) {},
            activeColor: ColorsApp.secondaryColor,
          ),
        ),
      ]),
    );
  }
}
