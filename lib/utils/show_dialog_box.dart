import 'package:authentication/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<bool> showDialogBox(context) async {
  bool itemAdded = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<NotesProvider>(
            builder: (context, notesProvider, child) {
          return AlertDialog(
            title: Text(
              "Enter details",
              style: TextStyle(fontSize: 20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Enter title",
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Enter description",
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  notesProvider.addNote(
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  itemAdded = true;
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          );
        });
      });
  titleController.text = "";
  descriptionController.text = "";
  return itemAdded;
}
