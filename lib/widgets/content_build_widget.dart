import 'package:flutter/material.dart';

class ContentBuildWidget extends StatelessWidget {
  final String? noteText;
  final ValueChanged<String> onChangedContent;

  const ContentBuildWidget({
    Key? key,
    this.noteText,
    required this.onChangedContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: noteText,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(
        fontSize: 18,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Your Content...',
      ),
      onChanged: onChangedContent,
    );
  }
}
