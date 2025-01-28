import 'package:flutter/material.dart';
import 'package:authentication/utils/store_user_data.dart';
import 'package:authentication/pages/login_page.dart';

class BuildSignupButton extends StatelessWidget {
  final TextEditingController userName, userEmail, userPassword;
  const BuildSignupButton(
      {super.key,
      required this.userName,
      required this.userEmail,
      required this.userPassword});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await storeUserData(
              userName: userName.text,
              userEmail: userEmail.text,
              userPassword: userPassword.text);
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error during signup: $e')),
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffcdeff1),
      ),
      child: Text(
        "Create Account",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
