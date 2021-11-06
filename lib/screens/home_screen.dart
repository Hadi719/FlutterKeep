import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../db/notes_database.dart';
import '../src/models/content_models.dart';
import '../src/models/note_model.dart';
import '../screens/edit_screen.dart';
import '../src/Util/screen_size_config.dart';
import '../src/widgets/note_card_widget.dart';

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

  // SliverAppBar Settings
  final bool _pinned = false;
  final bool _snap = false;
  final bool _floating = true;

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    // Loading the Notes.

    return isLoading
        ? loadingIndicator()
        : Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    sliver: SliverAppBar(
                      pinned: _pinned,
                      snap: _snap,
                      floating: _floating,
                      toolbarHeight: ScreenSizeConfig.safeBlockVertical * 7,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      leading: IconButton(
                        highlightColor: Colors.transparent,
                        icon: const Icon(
                          Icons.menu,
                        ),
                        iconSize: ScreenSizeConfig.safeBlockHorizontal * 7,
                        onPressed: () {},
                      ),
                    ),
                  ),
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 64, 16),
                height: ScreenSizeConfig.safeBlockVertical * 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      tooltip: 'Home',
                      highlightColor: Colors.transparent,
                      icon: Icon(
                        Icons.home_outlined,
                        size: ScreenSizeConfig.safeBlockHorizontal * 7,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      tooltip: 'Search',
                      highlightColor: Colors.transparent,
                      icon: Icon(
                        Icons.search_outlined,
                        size: ScreenSizeConfig.safeBlockHorizontal * 7,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      tooltip: 'About App',
                      highlightColor: Colors.transparent,
                      icon: Icon(
                        Icons.info_outline,
                        size: ScreenSizeConfig.safeBlockHorizontal * 7,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
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
