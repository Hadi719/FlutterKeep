import 'package:flutter/material.dart';
import 'package:flutter_note/src/Util/my_screen_size.dart';
import 'package:provider/provider.dart';

import '../db/notes_database.dart';
import '../src/models/content_models.dart';
import '../src/models/contents_data.dart';
import '../src/models/note_model.dart';
import '../screens/home_screen.dart';
import '../src/widgets/my_content_build_widget.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = 'edit_screen';
  final int? noteId;

  const EditScreen({
    Key? key,
    this.noteId,
  }) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late Note? note;
  late String title;
  late int getNoteID;
  late List<Content>? contentsList;
  late bool isCheckBox;
  bool isLoading = false;
  bool isNewNote = false;

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                buildDeleteButton(),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                        maxLines: 1,
                        initialValue: title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                        ),
                        validator: (title) => title != null && title.isEmpty
                            ? 'The title cannot be empty'
                            : null,
                        onChanged: (newTitle) {
                          setState(() => title = newTitle);
                        }),
                  ),
                  Consumer<ContentsData>(
                    builder: (context, contentsData, child) {
                      contentsList = contentsData.getContentList;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: contentsData.getContentsListLength,
                            itemBuilder: (context, index) {
                              Content content = contentsList![index];
                              return MyContentBuild(
                                noteText: content.noteText,
                                isCheckBox: isCheckBox,
                                isDone: content.isDone,
                                autofocus: true,
                                onChangeCheckBox: (bool? newValue) {
                                  content.isDone = newValue;
                                  contentsData.updateContent(index, content);
                                },
                                onChangedContent: (newNoteText) {
                                  return {
                                    content.noteText = newNoteText,
                                    contentsData.updateContent(index, content),
                                  };
                                },
                                onFieldSubmitted: (String value) {
                                  contentsData.addContent('', false);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  0,
                  0,
                  64,
                  MediaQuery.of(context).viewInsets.bottom + 16.0,
                ),
                height: MediaQuery.of(context).viewInsets.bottom +
                    ScreenSizeConfig.safeBlockVertical * 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildSaveButton(),
                    buildCheckBox(),
                  ],
                ),
              ),
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ContentsData>(context, listen: false).clearList;
    if (widget.noteId == null) {
      title = '';
      isCheckBox = false;
      Provider.of<ContentsData>(context, listen: false).addContent('', false);

      setState(() {
        isNewNote = true;
      });
    } else {
      refreshNote();
    }
  }

  Widget buildSaveButton() {
    final isFormValid = title.isNotEmpty && contentsList![0].noteText != '';

    return IconButton(
      highlightColor: Colors.transparent,
      icon: const Icon(Icons.save),
      tooltip: 'SAVE',
      color: isFormValid ? Colors.white : Colors.grey,
      onPressed: () async {
        if (isFormValid) {
          await addOrUpdateNote();
          await addAllContents();
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildCheckBox() {
    return IconButton(
      highlightColor: Colors.transparent,
      icon: const Icon(Icons.assignment_turned_in_outlined),
      tooltip: 'CheckBox',
      onPressed: () {
        // Provider.of<ContentsData>(context, listen: false).addContent('');
        setState(() {
          isCheckBox = !isCheckBox;
        });
      },
    );
  }

  Widget buildDeleteButton() {
    return IconButton(
      highlightColor: Colors.transparent,
      icon: const Icon(Icons.delete),
      tooltip: 'DELETE',
      onPressed: () async {
        await NotesDatabase.instance.deleteContents(widget.noteId!);
        await NotesDatabase.instance.deleteNote(widget.noteId!);
        Provider.of<ContentsData>(context, listen: false).clearList;
        Navigator.pushNamed(context, HomeScreen.routeName);
      },
    );
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });

    note = await NotesDatabase.instance.readNote(widget.noteId!);
    getNoteID = widget.noteId!;
    title = note!.title;
    isCheckBox = note!.isCheckBox;

    contentsList = await NotesDatabase.instance.readContent(widget.noteId!);

    int length = contentsList!.length;
    for (int index = 0; index < length; index++) {
      Provider.of<ContentsData>(context, listen: false).addContent(
          contentsList![index].noteText, contentsList![index].isDone);
    }

    setState(() => isLoading = false);
  }

  Future addOrUpdateNote() async {
    if (isNewNote) {
      await addNote();
    } else {
      await updateNote();
    }
  }

  Future addNote() async {
    final note = Note(
      title: title,
      isCheckBox: isCheckBox,
      time: DateTime.now(),
    );

    getNoteID = await NotesDatabase.instance.addNote(note);
  }

  Future updateNote() async {
    note = note!.add(
      title: title,
      isCheckBox: isCheckBox,
      time: DateTime.now(),
    );

    await NotesDatabase.instance.updateNote(note!);
  }

  /// Add all contents to database.
  Future addAllContents() async {
    /// Delete all previous contents from database.
    await NotesDatabase.instance.deleteContents(getNoteID);

    /// add new contents.
    final length =
        Provider.of<ContentsData>(context, listen: false).getContentsListLength;
    for (int index = 0; index < length; index++) {
      Content newContent = Provider.of<ContentsData>(context, listen: false)
          .getContentList[index];
      newContent.contentNoteId = getNoteID;

      /// Test if content TEXT isEmpty.
      String _testText = newContent.noteText.replaceAll(' ', '');
      if (_testText != '') {
        await NotesDatabase.instance.addContent(newContent);
      }
    }
  }
}
