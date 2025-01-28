import 'package:authentication/widgets/build_sizebox.dart';
import 'package:flutter/material.dart';

class BuildCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final int color;
  const BuildCard({super.key, required this.item, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(color),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item["title"],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            BuildSizebox(height: 10),
            Text(item["description"]),
          ],
        ),
      ),
    );
  }
}
