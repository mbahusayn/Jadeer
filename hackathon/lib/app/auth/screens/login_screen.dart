import 'package:flutter/material.dart';
import 'package:hackathon/app/auth/screens/signup_screen.dart';
import 'package:hackathon/app/common_widget.dart/button.dart';
import 'package:hackathon/app/common_widget.dart/text_field.dart';
import 'package:hackathon/app/navigation_bar.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.jpg",
              width: 100,
            ),
            height16,
            const Text(
              "أهلاً بك",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text("سجل دخول للمتابعة"),
            height32,
            Directionality(
              textDirection: TextDirection.ltr,
              child: TextFieldWidget(
                controller: emailController,
                hint: "email",
              ),
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: TextFieldWidget(
                controller: passwordController,
                hint: "password",
                isPassword: true,
              ),
            ),
            height16,
            ElevatedButtonWidget(
                onPressed: () async {
                  try {
                    final supabase = Supabase.instance.client;
                    await supabase.auth.signInWithPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    if (!context.mounted) return;
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
                text: "تسجيل الدخول"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("لا تملك حساب ؟ "),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                    },
                    child: const Text(
                      "إنشاء حساب",
                      style: TextStyle(color: ColorsApp.primaryColor),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
