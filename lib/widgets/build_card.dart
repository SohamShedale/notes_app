import 'package:authentication/pages/data_list.dart';
import 'package:authentication/widgets/build_sizebox.dart';
import 'package:flutter/material.dart';

class BuildCard extends StatelessWidget {
  final DataItem item;
  const BuildCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            BuildSizebox(height: 10),
            Text(item.description),
          ],
        ),
      ),
    );
  }
}
