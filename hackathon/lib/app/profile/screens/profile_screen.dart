import 'package:flutter/material.dart';
import 'package:hackathon/app/auth/screens/loading_screen.dart';
import 'package:hackathon/app/auth/screens/login_screen.dart';
import 'package:hackathon/app/profile/screens/account_screen.dart';
import 'package:hackathon/app/profile/screens/settings_screen.dart';
import 'package:hackathon/app/profile/widgets/profile_tile.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "حسابي",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black)),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: ColorsApp.greyColor, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),
                ),
                width16,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUser.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentUser.username,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: ColorsApp.secondaryColor,
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
          height24,
          const ProfileTile(
            text: "الحساب المصرفي",
            icon: Icons.account_balance_wallet_outlined,
            screen: AccountScreen(),
          ),
          const Divider(indent: 16, endIndent: 16),
          const ProfileTile(
            text: "الإعدادات",
            icon: Icons.settings_outlined,
            screen: SettingsScreen(),
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16)),
              child: const Icon(
                Icons.ios_share,
                color: ColorsApp.primaryColor,
              ),
            ),
            title: const Text("تصدير البيانات"),
          ),
          const Divider(indent: 16, endIndent: 16),
          GestureDetector(
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
              currentUser.id = 0;
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                (route) => false,
              );
            },
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(
                  Icons.logout,
                  color: ColorsApp.primaryColor,
                ),
              ),
              title: const Text("تسجيل خروج"),
            ),
          ),
          const Divider(indent: 16, endIndent: 16),
        ],
      ),
    );
  }
}
