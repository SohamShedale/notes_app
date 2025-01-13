import 'package:authentication/data_list.dart';
import 'package:authentication/signup_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  List<Map<String, dynamic>> users = [];

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

  Future<List<Map<String, dynamic>>> loadUserData() async {
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/signup_data.json');
      final jsonString = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      return [];
    }
  }

  void findUser(List userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString("userEmail");
    final userPassword = prefs.getString("userPassword");
    if (userEmail == _emailController.text &&
        userPassword == _passwordController.text) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DataList(),
          ),
        );
      }
    } else {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    }
  }

  Widget _buildMaterial({
    required String hintText,
    required TextEditingController controller,
    bool obsecureText = false,
  }) {
    return Material(
      elevation: 15,
      borderRadius: BorderRadius.circular(40),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(140, 92, 179, 1),
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMaterial(
                hintText: "Enter your email",
                controller: _emailController,
              ),
              SizedBox(
                height: 20,
              ),
              _buildMaterial(
                hintText: "Enter password",
                controller: _passwordController,
                obsecureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  users = await loadUserData();
                  findUser(users);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Already have an account?",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
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
