import 'package:flutter/material.dart';
import 'package:hackathon/app/auth/screens/signup_screen.dart';
import 'package:hackathon/app/common_widget.dart/text_field.dart';
import 'package:hackathon/app/navigation_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldWidget(
              controller: emailController,
              hint: "email",
            ),
            TextFieldWidget(
              controller: passwordController,
              hint: "password",
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final supabase = Supabase.instance.client;
                    await supabase.auth.signInWithPassword(
                        email: emailController.text,
                        password: passwordController.text);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppNavigationBar(),
                      ),
                      (route) => false,
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text("Log in")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                },
                child: const Text("sign up"))
          ],
        ),
      ),
    );
  }
}
