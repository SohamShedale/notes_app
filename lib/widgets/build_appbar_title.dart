import 'package:flutter/material.dart';

class BuildAppbarTitle extends StatelessWidget {
  final String title;
  const BuildAppbarTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: Color(0xfffca590),
      ),
    );
  }
}
