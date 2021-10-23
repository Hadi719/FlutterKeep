import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  final String? noteText;
  final ValueChanged<String> onChangedContent;

  const ContentWidget({
    Key? key,
    this.noteText,
    required this.onChangedContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      initialValue: noteText,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Your Content...',
      ),
      onChanged: onChangedContent,
    );
  }
}
