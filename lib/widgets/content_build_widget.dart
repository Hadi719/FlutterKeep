import 'package:flutter/material.dart';

import '../src/Util/screen_size_config.dart';

class ContentBuildWidget extends StatelessWidget {
  final String? noteText;
  final bool isCheckBox;
  final bool? isDone;
  final Function(String)? onChangedContent;
  final ValueChanged<bool?> onChangeCheckBox;
  final Function(String)? onFieldSubmitted;

  const ContentBuildWidget({
    Key? key,
    this.noteText,
    required this.isCheckBox,
    this.isDone,
    required this.onChangedContent,
    required this.onChangeCheckBox,
    required this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    if (isCheckBox) {
      return ListTile(
        leading: Icon(
          Icons.list,
          size: ScreenSizeConfig.safeBlockHorizontal * 7,
        ),
        title: TextFormField(
          initialValue: noteText,
          maxLines: 1,
          textInputAction: TextInputAction.go,
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
