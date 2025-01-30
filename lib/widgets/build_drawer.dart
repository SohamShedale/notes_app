import 'package:authentication/pages/archive_page.dart';
import 'package:authentication/pages/help_page.dart';
import 'package:authentication/pages/notes_page.dart';
import 'package:authentication/pages/trash_page.dart';
import 'package:authentication/providers/drawer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildDrawer extends StatefulWidget {
  const BuildDrawer({super.key});

  @override
  State<BuildDrawer> createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff202124),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
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
          _buildMenuItem(0, Icons.lightbulb_outline, "My Notes", NotesPage()),
          _buildMenuItem(1, Icons.archive_outlined, "Archive", ArchivePage()),
          _buildMenuItem(2, Icons.delete_outline, "Trash", TrashPage()),
          _buildMenuItem(3, Icons.help_outline, "Help & feedback", HelpPage()),
        ],
      ),
    );
  }
}

Widget _buildMenuItem(int index, IconData icon, String title, Widget page) {
  return Consumer<DrawerProvider>(builder: (context, drawerProvider, child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: (drawerProvider.selectedIndex == index)
            ? Color(0xff41331c)
            : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        selected: drawerProvider.selectedIndex == index,
        onTap: () {
          drawerProvider.updateSelectedIndexint(index);
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  });
}
