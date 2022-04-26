import 'package:flutter/material.dart';
import 'package:flutter_keep/src/models/content_models.dart';
import 'package:flutter_keep/src/widgets/my_content_view_widget.dart';

import '../models/note_model.dart';
import 'package:flutter_keep/src/util/my_screen_size.dart';

final _lightColors = [
  Colors.deepPurple,
  Colors.indigo,
  Colors.lightBlue,
  Colors.teal,
  Colors.deepOrange,
  Colors.blueGrey
];

class MyNoteCard extends StatelessWidget {
  const MyNoteCard({
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
    MyScreenSize().init(context);
    return Card(
      color: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Container(
        width: MyScreenSize.safeBlockHorizontal * 45,
        // constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.fromLTRB(20, 20, 8, 20),
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
            const SizedBox(height: 10.0),
            MyContentView(contentsList: contentsList)
          ],
        ),
      ),
    );
  }
}
