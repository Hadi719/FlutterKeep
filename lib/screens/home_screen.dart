import 'package:flutter/material.dart';
import 'package:flutter_note/widgets/note_card_widget.dart';

import '../db/notes_database.dart';
import '../models/content_models.dart';
import '../models/note_model.dart';
import '../screens/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Note> notes;
  late List<Content> allContents;
  bool isLoading = false;

  /// SliverAppBar Settings
  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;

  @override
  void initState() {
    super.initState();

    // Getting all notes from database.
    refreshNotes();
  }

  @override
  void dispose() {
    // close database when app closed.
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    // Get all notes from database.
    notes = await NotesDatabase.instance.readAllNotes();
    allContents = await NotesDatabase.instance.readAllContents();

    setState(() => isLoading = false);
  }

  Widget loadingIndicator() {
    refreshNotes();
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Loading the Notes.
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            body: SafeArea(
              child: buildGridView(context),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.purple,
              child: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.pushNamed(context, EditScreen.routeName);

                refreshNotes();
              },
            ),
          );
  }

  Widget buildGridView(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: GridView.builder(
        itemCount: notes.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          Note note = notes[index];
          List<Content> contentsList = [];
          for (var content in allContents) {
            if (content.contentNoteId == note.noteId) {
              contentsList.add(content);
            }
          }
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditScreen(noteId: note.noteId!),
                ),
              );
            },
            child: NoteCardWidget(
                note: note, index: index, contentsList: contentsList),
          );
        },
      ),
    );
  }
}
