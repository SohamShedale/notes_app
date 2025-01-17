import 'package:authentication/constants/data.dart';
import 'package:authentication/pages/data_list.dart';
import 'package:flutter/material.dart';

Future<bool> showDialogBox(
    context, titleController, descriptionController) async {
  bool itemAdded = false;
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
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
            dataItem.add(DataItem(
              title: titleController.text,
              description: descriptionController.text,
            ));
            itemAdded = true;
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    ),
  );
  titleController.text = "";
  descriptionController.text = "";
  return itemAdded;
}
