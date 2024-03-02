import 'package:flutter/material.dart';
import 'package:hackathon/app/auth/screens/login_screen.dart';
import 'package:hackathon/app/common_widget.dart/text_field.dart';
import 'package:hackathon/services/supabase_functions.dart';
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
        title: const Text("Sign Up"),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldWidget(
              controller: nameController,
              hint: "name",
            ),
            TextFieldWidget(
              controller: usernameController,
              hint: "username",
            ),
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
                child: const Text("Sign up"))
          ],
        ),
      ),
    );
  }
}
