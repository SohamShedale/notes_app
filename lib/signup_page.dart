import 'package:authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> storeData() async {
    try {
      List<Map<String, dynamic>> userData = [
        {
          "userName": _nameController.text,
          "userEmail": _emailController.text,
          "userPassword": _passwordController.text,
        }
      ];
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/signup_data.json');
      if (!await file.exists()) {
        await file.create();
      }
      final jsonString = await file.readAsString();
      final dynamic existingData;
      if (jsonString.isNotEmpty) {
        existingData = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
      } else {
        existingData = [];
      }
      existingData.add(userData[0]);
      final updatedJsonString = jsonEncode(existingData);
      await file.writeAsString(updatedJsonString);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userEmail", _emailController.text);
      prefs.setString("userPassword", _passwordController.text);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    } catch (e) {
      throw e.toString();
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
          "Sign Up",
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
                hintText: "Enter your name",
                controller: _nameController,
              ),
              SizedBox(
                height: 20,
              ),
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
                onPressed: storeData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  "Create Account",
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
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "Login",
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
