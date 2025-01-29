import 'package:authentication/providers/search_notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchNotesProvider>(
      builder: (context, searchNotesProvider, child) => TextField(
        onChanged: (String value) {
          searchNotesProvider.searchNote(context, value);
        },
        cursorColor: Colors.white,
        controller: searchController,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xff525355),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: Scaffold.of(context).openDrawer,
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            );
          }),
        ),
      ),
    );
  }
}
