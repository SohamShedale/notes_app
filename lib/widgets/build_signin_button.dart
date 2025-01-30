import 'package:authentication/pages/notes_page.dart';
import 'package:authentication/pages/login_page.dart';
import 'package:authentication/utils/find_user.dart';
import 'package:flutter/material.dart';

class BuildSigninButton extends StatelessWidget {
  final TextEditingController emailController, passwordController;
  const BuildSigninButton(
      {super.key,
      required this.emailController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        bool success = await findUser(
            emailController: emailController,
            passwordController: passwordController);
        if (success) {
          if (context.mounted) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NotesPage()));
          }
        } else {
          if (context.mounted) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffcdeff1),
      ),
      child: Text(
        "Login",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
