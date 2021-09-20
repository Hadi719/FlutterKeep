import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final String? title;
  final String? content;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedContent;

  const NoteFormWidget({
    Key? key,
    this.title = '',
    this.content = '',
    required this.onChangedTitle,
    required this.onChangedContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 8),
              buildContent(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildContent() => TextFormField(
        maxLines: 5,
        initialValue: content,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
        ),
        validator: (content) => content != null && content.isEmpty
            ? 'The content cannot be empty'
            : null,
        onChanged: onChangedContent,
      );
}
