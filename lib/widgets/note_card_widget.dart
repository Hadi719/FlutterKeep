import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/models/content_models.dart';
import 'package:flutter_note/widgets/content_view_widget.dart';

import '../models/note_model.dart';
import '../src/Util/screen_size_config.dart';

final _lightColors = [
  Colors.deepPurple,
  Colors.green,
  Colors.lightBlue,
  Colors.orange,
  Colors.pinkAccent,
  Colors.tealAccent
];

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
    required this.contentsList,
  }) : super(key: key);

  final Note note;
  final int index;
  final List<Content> contentsList;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    // final timeDate = DateFormat('d MMM, y').format(note.createdTime);
    // final timeHour = DateFormat('HH : mm').format(note.createdTime);
    ScreenSizeConfig().init(context);
    return Card(
      color: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Container(
        width: ScreenSizeConfig.safeBlockHorizontal * 45,
        // constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.fromLTRB(20, 20, 8, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              textScaleFactor: 1,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ContentViewWidget(contentsList: contentsList)
          ],
        ),
      ),
    );
  }
}
