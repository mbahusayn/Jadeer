import 'package:flutter/material.dart';
import 'package:hackathon/style/colors.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.text,
    required this.icon,
    required this.screen,
  });
  final String text;
  final IconData icon;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      child: ListTile(
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
      ),
    );
  }
}
