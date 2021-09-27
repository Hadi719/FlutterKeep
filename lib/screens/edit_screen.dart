import 'package:flutter/material.dart';

import '../db/notes_database.dart';
import '../models/note_model.dart';
import '../widgets/note_form_widget.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  final Content? content;

  const EditScreen({Key? key, this.note, this.content}) : super(key: key);
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String noteText;
  late int getNoteID;

  @override
  void initState() {
    super.initState();

    title = widget.note?.title ?? '';
    noteText = widget.content?.noteText ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            title: title,
            noteText: noteText,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedContent: (newNoteText) =>
                setState(() => noteText = newNoteText),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && noteText.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: () async {
          await addOrUpdateNote();
          await addOrUpdateContent();
          Navigator.of(context).pop();
        },
        child: const Text('Save'),
      ),
    );
  }

  Future addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }
    }
  }

  Future addOrUpdateContent() async {
    final isUpdating = widget.content != null;
    if (isUpdating) {
      await updateContent();
    } else {
      await addContent();
    }
  }

  Future updateNote() async {
    final note = widget.note!.add(
      title: title,
    );

    await NotesDatabase.instance.updateNote(note);
  }

  Future updateContent() async {
    final content = widget.content!.add(
      noteText: noteText,
    );

    await NotesDatabase.instance.updateContent(content);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      createdTime: DateTime.now(),
    );

    getNoteID = await NotesDatabase.instance.addNote(note);
    //TODO Print call getNoteID
    print('Note ID: ' + getNoteID.toString());
  }

  Future addContent() async {
    final content = Content(
      noteText: noteText,
      contentNoteId: getNoteID,
      //TODO: adding CheckBox
      checkBox: false,
      isDone: false,
    );

    await NotesDatabase.instance.addContent(content);
  }
}
