import 'package:flutter/material.dart';
import 'package:hackathon/app/auth/screens/login_screen.dart';
import 'package:hackathon/app/common_widget.dart/button.dart';
import 'package:hackathon/app/common_widget.dart/text_field.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/services/supabase_functions.dart';
import 'package:hackathon/style/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
      ),
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
              "إنشاء حساب جديد",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            height24,
            TextFieldWidget(
              controller: nameController,
              hint: "الاسم",
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: TextFieldWidget(
                controller: usernameController,
                hint: "username",
              ),
            ),
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
            height32,
            ElevatedButtonWidget(
                onPressed: () async {
                  try {
                    final supabase = Supabase.instance.client;
                    await supabase.auth
                        .signUp(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      SupabaseFunctions().addNewUser({
                        "name": nameController.text,
                        "username": usernameController.text,
                        "email": emailController.text
                      });
                    });
                    if (!context.mounted) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                  }
                },
                text: "إنشاء حساب"),
            height8,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("لديك حساب بالفعل ؟ "),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                    },
                    child: const Text(
                      "تسجيل الدخول",
                      style: TextStyle(color: ColorsApp.primaryColor),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
