import 'package:flutter/material.dart';
import 'package:flutter_note/widgets/old_note_card_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../db/notes_database.dart';
import '../models/content_models.dart';
import '../models/note_model.dart';
import '../screens/edit_screen.dart';

class OldHomeScreen extends StatefulWidget {
  const OldHomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'home_screen';

  @override
  _OldHomeScreenState createState() => _OldHomeScreenState();
}

class _OldHomeScreenState extends State<OldHomeScreen> {
  late List<Note> notes;
  late List<Content> contents;
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

    setState(() => isLoading = false);
  }

  Widget loadingIndicator() {
    refreshNotes();
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    // Loading the Notes.
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: _pinned,
                    snap: _snap,
                    floating: _floating,
                    // AppBar Height => 1/3 of screen Height
                    expandedHeight: MediaQuery.of(context).size.height / 3,
                    backgroundColor: Colors.deepPurple,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text('MY NOTE'),
                      background: Padding(
                        padding: EdgeInsets.only(left: 100.0),
                        child: FlutterLogo(),
                      ),
                    ),
                  ),
                  buildNotes(),
                ],
              ),
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

  Widget buildNotes() {
    return SliverStaggeredGrid.countBuilder(
      itemCount: notes.length,
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      itemBuilder: (context, index) {
        final note = notes[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditScreen(noteId: note.noteId!),
              ),
            );

            refreshNotes();
          },
          child: OldNoteCardWidget(note: note, index: index),
        );
      },
    );
  }
}
