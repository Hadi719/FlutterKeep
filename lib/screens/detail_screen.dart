import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/notes_database.dart';
import '../models/note_model.dart';
import '../screens/edit_screen.dart';

class DetailScreen extends StatefulWidget {
  final int noteId;

  const DetailScreen({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Note note;
  late Content content;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    note = await NotesDatabase.instance.readNote(widget.noteId);
    //TODO print call: IDs in Detail Screen
    print('Note ID in Detail Screen: ' + note.noteId.toString());
    content = await NotesDatabase.instance.readContent(widget.noteId);
    print('Content ID in Detail Screen: ' + content.contentId.toString());
    print(
        'Content NoteID in Detail Screen: ' + content.contentNoteId.toString());

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(note.createdTime),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      content.noteText,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditScreen(note: note, content: content),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.deleteNote(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
