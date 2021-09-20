import 'package:flutter/material.dart';

import '../db/notes_database.dart';
import '../models/note_model.dart';
import '../widgets/note_form_widget.dart';

class EditScreen extends StatefulWidget {
  final Note? note;

  const EditScreen({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String content;

  @override
  void initState() {
    super.initState();

    title = widget.note?.title ?? '';
    content = widget.note?.content ?? '';
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
            content: content,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedContent: (content) =>
                setState(() => this.content = content),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && content.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      title: title,
      content: content,
    );

    await NotesDatabase.instance.updateNote(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      content: content,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.addNote(note);
  }
}
