import 'package:flutter/material.dart';

class BuildText extends StatelessWidget {
  final String text;
  const BuildText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 15),
    );
  }
}
