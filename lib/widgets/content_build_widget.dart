import 'package:flutter/material.dart';

class ContentBuildWidget extends StatelessWidget {
  final String? noteText;
  final bool isCheckBox;
  final bool isDone;
  final ValueChanged<String> onChangedContent;
  final ValueChanged<bool?> onChangeCheckBox;

  const ContentBuildWidget({
    Key? key,
    this.noteText,
    required this.isCheckBox,
    this.isDone = false,
    required this.onChangedContent,
    required this.onChangeCheckBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isCheckBox) {
      return CheckboxListTile(
        value: isDone,
        onChanged: (bool? newValue) {
          isDone == newValue;
        },
      );
    } else {
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
}
