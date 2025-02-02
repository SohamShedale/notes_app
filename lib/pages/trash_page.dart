import 'package:authentication/providers/notes_provider.dart';
import 'package:authentication/widgets/build_drawer.dart';
import 'package:authentication/widgets/build_text.dart';
import 'package:authentication/widgets/build_trashed_notes_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff202124),
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ));
        }),
      ),
      drawer: BuildDrawer(),
      body: SafeArea(
        child:
            Consumer<NotesProvider>(builder: (context, notesProvider, child) {
          List<Map<String, dynamic>> archivedNotes = notesProvider.notes
              .where((note) => (note["status"] == "deleted"))
              .toList();
          if (notesProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return (archivedNotes.isNotEmpty)
                ? BuildTrashedNotesGrid()
                : Center(
                    child: BuildText(text: "No deleted notes"),
                  );
          }
        }),
      ),
    );
  }
}
