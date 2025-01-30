import 'package:authentication/providers/notes_provider.dart';
import 'package:authentication/providers/search_notes_provider.dart';
import 'package:authentication/utils/show_dialog_box.dart';
import 'package:authentication/widgets/build_all_notes_grid.dart';
import 'package:authentication/widgets/build_drawer.dart';
import 'package:authentication/widgets/build_searched_notes_grid.dart';
import 'package:authentication/widgets/build_text.dart';
import 'package:authentication/widgets/build_text_field.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotesProvider>(context, listen: false).getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (context, notesProvider, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff202124),
          title: BuildTextField(),
        ),
        drawer: BuildDrawer(),
        body: SafeArea(
          child: Consumer<SearchNotesProvider>(
              builder: (context, searchNotesProvider, child) {
            if (notesProvider.isLoading || searchNotesProvider.isLoading) {
              return CircularProgressIndicator();
            } else if (notesProvider.error != null ||
                searchNotesProvider.error != null) {
              return Center(
                child: Column(
                  children: [
                    BuildText(
                      text: (notesProvider.error != null)
                          ? notesProvider.error!
                          : searchNotesProvider.error!,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text("Refresh"),
                    )
                  ],
                ),
              );
            } else if (notesProvider.notes.isEmpty) {
              return Center(
                child: BuildText(text: "No notes yet"),
              );
            } else if (notesProvider.notes.isNotEmpty &&
                searchNotesProvider.searchedNotes.isEmpty &&
                searchNotesProvider.query.isNotEmpty) {
              return Center(
                child: BuildText(text: "Match not found"),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: (searchNotesProvider.searchedNotes.isNotEmpty)
                    ? BuildSearchedNotesGrid()
                    : BuildAllDataGrid(),
              );
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool isItemAdded = await showDialogBox(context);
            if (isItemAdded) {
              setState(() {});
            }
          },
          tooltip: "Add note",
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
