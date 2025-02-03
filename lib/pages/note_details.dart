import 'package:authentication/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteDetails extends StatefulWidget {
  final Map<String, dynamic> item;
  const NoteDetails({super.key, required this.item});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late String daysRemaining;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.item["title"];
    _descriptionController.text = widget.item["description"];
    if (widget.item["status"] == "deleted") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<NotesProvider>(context, listen: false)
            .calculateDays(id: widget.item["id"]);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (context, notesProvider, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff202124),
          actions: [
            if (widget.item["status"] != "deleted")
              IconButton(
                onPressed: () {
                  (widget.item["status"] == "archived")
                      ? notesProvider.unArchiveNote(id: widget.item["id"])
                      : notesProvider.archiveNote(id: widget.item['id']);
                },
                icon: (widget.item["status"] == "archived")
                    ? Icon(Icons.unarchive_outlined)
                    : Icon(Icons.archive_outlined),
              ),
            if (widget.item["status"] != "deleted")
              IconButton(
                  onPressed: () {
                    notesProvider.deleteNote(id: widget.item["id"]);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete)),
            Padding(
              padding: EdgeInsets.only(
                right: 15,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  if (widget.item["status"] == "deleted")
                    Text(
                      "After ${(int.parse("7") - notesProvider.days).toString()} days note will get permanently deleted.",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  TextField(
                    controller: _titleController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: TextField(
                      onEditingComplete: () {
                        _focusNode.unfocus();
                        notesProvider.editNote(
                          id: widget.item["id"],
                          title: _titleController.text,
                          description: _descriptionController.text,
                        );
                      },
                      controller: _descriptionController,
                      focusNode: _focusNode,
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
