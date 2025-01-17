import 'package:flutter/material.dart';

class BuildMaterial extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obsecureText;
  const BuildMaterial({
    super.key,
    required this.hintText,
    required this.controller,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
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
}
