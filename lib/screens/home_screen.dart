import 'package:flutter/material.dart';
import 'package:flutter_keep/db/notes_database.dart';
import 'package:flutter_keep/screens/edit_screen.dart';
import 'package:flutter_keep/src/models/content_models.dart';
import 'package:flutter_keep/src/models/note_model.dart';
import 'package:flutter_keep/src/util/my_screen_size.dart';
import 'package:flutter_keep/src/widgets/my_bottom_nav_bar_widget.dart';
import 'package:flutter_keep/src/widgets/my_drawer_widget.dart';
import 'package:flutter_keep/src/widgets/my_note_card_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Note> notes;
  late List<Content> allContents;
  bool isLoading = false;

  // SliverAppBar Settings
  final bool _pinned = false;
  final bool _snap = false;
  final bool _floating = true;

  @override
  Widget build(BuildContext context) {
    MyScreenSize().init(context);

    return isLoading
        ? loadingIndicator()
        : Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    sliver: SliverAppBar(
                      pinned: _pinned,
                      snap: _snap,
                      floating: _floating,
                      toolbarHeight: MyScreenSize.safeBlockVertical * 7,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      leading: const MyAppBarLeadingIcon(),
                    ),
                  ),
                  SliverMasonryGrid.count(
                    childCount: notes.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
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
                          await Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditScreen(noteId: note.noteId!),
                            ),
                          )
                              .then((value) {
                            setState(() {
                              refreshNotes();
                            });
                          });
                        },
                        child: MyNoteCard(
                          note: note,
                          index: index,
                          contentsList: contentsList,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            drawer: const MyDrawer(routeName: HomeScreen.routeName),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.grey.shade800,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () async {
                await Navigator.pushNamed(context, EditScreen.routeName)
                    .then((value) {
                  setState(() {
                    refreshNotes();
                  });
                });
              },
            ),
            bottomNavigationBar: const MyBottomNavBar(
              routeName: HomeScreen.routeName,
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
}

class MyAppBarLeadingIcon extends StatelessWidget {
  const MyAppBarLeadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      highlightColor: Colors.transparent,
      icon: const Icon(
        Icons.menu,
      ),
      iconSize: MyScreenSize.safeBlockHorizontal * 7,
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
