import 'package:flutter/material.dart';
import 'package:flutter_note/widgets/note_card_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

  @override
  Widget build(BuildContext context) {
    // Loading the Notes.
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverStaggeredGrid.countBuilder(
                    itemCount: notes.length,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                    itemBuilder: (context, index) {
                      final note = notes[index];
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
                              builder: (context) =>
                                  EditScreen(noteId: note.noteId!),
                            ),
                          );
                        },
                        child: NoteCardWidget(
                          note: note,
                          index: index,
                          contentsList: contentsList,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.pushNamed(context, EditScreen.routeName);
              },
            ),
          );
  }

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

  Widget buildGridView() {
    return CustomScrollView(
      slivers: [
        SliverList(
          // gridDelegate:
          //     const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
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
            childCount: notes.length,
          ),
        ),
      ],
    );
  }
}
