import 'package:authentication/widgets/build_appbar_title.dart';
import 'package:authentication/widgets/build_signup_button.dart';
import 'package:authentication/widgets/build_sizebox.dart';
import 'package:authentication/pages/login_page.dart';
import 'package:authentication/widgets/build_material.dart';
import 'package:authentication/widgets/build_text.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff202124),
        title: BuildAppbarTitle(title: "Signup"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildMaterial(
                hintText: "Enter your name",
                controller: _nameController,
              ),
              BuildSizebox(height: 20),
              BuildMaterial(
                hintText: "Enter your email",
                controller: _emailController,
              ),
              BuildSizebox(height: 20),
              BuildMaterial(
                hintText: "Enter password",
                controller: _passwordController,
                obsecureText: true,
              ),
              BuildSizebox(height: 30),
              BuildSignupButton(
                userName: _nameController,
                userEmail: _emailController,
                userPassword: _passwordController,
              ),
              BuildText(text: "Already have an account?"),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Color(0xffffffa0),
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
