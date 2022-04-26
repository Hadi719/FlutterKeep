import 'package:flutter/material.dart';
import 'package:flutter_keep/src/util/my_screen_size.dart';

class MyContentBuild extends StatelessWidget {
  final String? noteText;
  final bool isCheckBox;
  final bool? isDone;
  final bool autofocus;
  final Function(String)? onChangedContent;
  final ValueChanged<bool?> onChangeCheckBox;
  final Function(String)? onFieldSubmitted;

  const MyContentBuild({
    Key? key,
    this.noteText,
    required this.isCheckBox,
    this.isDone,
    this.autofocus = false,
    required this.onChangedContent,
    required this.onChangeCheckBox,
    required this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyScreenSize().init(context);
    if (isCheckBox) {
      return ListTile(
        leading: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isDone,
          onChanged: onChangeCheckBox,
        ),
        title: TextFormField(
          initialValue: noteText,
          maxLines: 1,
          textInputAction: TextInputAction.done,
          autofocus: true,
          style: TextStyle(
            fontSize: 18,
            decoration: isDone! ? TextDecoration.lineThrough : null,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Your Content...',
          ),
          onChanged: onChangedContent,
          onFieldSubmitted: onFieldSubmitted,
        ),
      );
    } else {
      return TextFormField(
        initialValue: noteText,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        autofocus: true,
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
