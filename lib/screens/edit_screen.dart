import 'package:flutter/material.dart';
import 'package:flutter_note/models/contents_data.dart';
import 'package:flutter_note/screens/old_home_screen.dart';
import 'package:provider/provider.dart';

import '../db/notes_database.dart';
import '../models/content_models.dart';
import '../models/note_model.dart';
import '../widgets/content_build_widget.dart';

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
  bool isLoading = false;
  bool isNewNote = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              actions: [
                buildAddButton(),
                buildSaveButton(),
                deleteButton(),
              ],
            ),
            body: Column(
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
                            return ContentBuildWidget(
                              noteText: content.noteText,
                              onChangedContent: (newNoteText) {
                                return setState(() {
                                  content.noteText = newNoteText;
                                  contentsData.updateContent(index, content);
                                });
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
          );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ContentsData>(context, listen: false).clearList;
    if (widget.noteId == null) {
      setState(() {
        isLoading = true;
      });

      title = '';
      Provider.of<ContentsData>(context, listen: false).addContent('');

      setState(() {
        isLoading = false;
        isNewNote = true;
      });
    } else {
      refreshNote();
    }
  }

  Widget buildSaveButton() {
    final isFormValid = title.isNotEmpty && contentsList![0].noteText != '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: IconButton(
        icon: const Icon(Icons.save),
        tooltip: 'SAVE',
        color: isFormValid ? Colors.white : Colors.grey,
        onPressed: () async {
          if (isFormValid) {
            await addOrUpdateNote();
            await addAllContents();
            Navigator.pushNamed(context, OldHomeScreen.routeName);
          }
        },
      ),
    );
  }

  Widget buildAddButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: IconButton(
        icon: const Icon(Icons.add),
        tooltip: 'Add New Content',
        onPressed: () {
          Provider.of<ContentsData>(context, listen: false).addContent('');
        },
      ),
    );
  }

  Widget deleteButton() {
    return IconButton(
      icon: const Icon(Icons.delete),
      tooltip: 'DELETE',
      onPressed: () async {
        await NotesDatabase.instance.deleteContents(widget.noteId!);
        await NotesDatabase.instance.deleteNote(widget.noteId!);
        Provider.of<ContentsData>(context, listen: false).clearList;
        Navigator.pushNamed(context, OldHomeScreen.routeName);
      },
    );
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });

    note = await NotesDatabase.instance.readNote(widget.noteId!);
    title = note!.title;
    getNoteID = widget.noteId!;

    contentsList = await NotesDatabase.instance.readContent(widget.noteId!);

    int length = contentsList!.length;
    for (int index = 0; index < length; index++) {
      Provider.of<ContentsData>(context, listen: false)
          .addContent(contentsList![index].noteText);
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
      createdTime: DateTime.now(),
    );

    getNoteID = await NotesDatabase.instance.addNote(note);
  }

  Future updateNote() async {
    note = note!.add(
      title: title,
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

      ///Test if content TEXT isEmpty.
      String _testText = newContent.noteText.replaceAll(' ', '');
      if (_testText != '') {
        await NotesDatabase.instance.addContent(newContent);
      }
    }
  }
}
