import 'package:flutter/material.dart';

class BuildSizebox extends StatelessWidget {
  final double height;
  const BuildSizebox({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
