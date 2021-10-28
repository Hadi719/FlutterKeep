import 'package:flutter/material.dart';

class ContentBuildWidget extends StatelessWidget {
  final String? noteText;
  final bool isCheckBox;
  final bool? isDone;
  final Function(String)? onChangedContent;
  final ValueChanged<bool?> onChangeCheckBox;

  const ContentBuildWidget({
    Key? key,
    this.noteText,
    required this.isCheckBox,
    this.isDone,
    required this.onChangedContent,
    required this.onChangeCheckBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isCheckBox) {
      return ListTile(
        leading: const Icon(Icons.list),
        title: TextFormField(
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
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isDone,
          onChanged: onChangeCheckBox,
        ),
        // onTap: onTapCallback,
        // onLongPress: longPressCallback,
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
