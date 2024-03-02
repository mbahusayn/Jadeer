import 'package:flutter/material.dart';
import 'package:hackathon/app/auth/screens/login_screen.dart';
import 'package:hackathon/app/navigation_bar.dart';
import 'package:hackathon/app/profile/model/user.dart' as user;
import 'package:hackathon/services/supabase_functions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late user.User currentUser;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isExpired = true;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    final supabase = Supabase.instance.client;
    Future.delayed(const Duration(seconds: 1), () async {
      if (supabase.auth.currentSession != null) {
        isExpired = supabase.auth.currentSession!.isExpired;
      } else {
        isExpired = true;
      }
      isLoading = false;
      currentUser = (await SupabaseFunctions().getLoggedInUser()) as user.User;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LogoScreen()
        : isExpired
            ? LoginScreen()
            : const AppNavigationBar();
  }
}

class LogoScreen extends StatelessWidget {
  const LogoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.text_format,
          size: 40,
        ),
      ),
    );
  }
}
