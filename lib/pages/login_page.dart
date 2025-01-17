import 'package:authentication/pages/signup_page.dart';
import 'package:authentication/widgets/build_appbar_title.dart';
import 'package:authentication/widgets/build_material.dart';
import 'package:authentication/widgets/build_signin_button.dart';
import 'package:authentication/widgets/build_sizebox.dart';
import 'package:authentication/widgets/build_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(140, 92, 179, 1),
        title: BuildAppbarTitle(title: "Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              BuildSigninButton(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              BuildText(text: "Don't have an account?"),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
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
