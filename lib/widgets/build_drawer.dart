import 'package:flutter/material.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color(0xff202124),
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Notes App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFD166),
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.lightbulb,
                color: Colors.white,
              ),
              title: Text(
                'My Notes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.archive,
                color: Colors.white,
              ),
              title: Text(
                'Archive',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              title: Text(
                'Trash',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.white,
              ),
              title: Text(
                'Help & feedback',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      );
  }
}