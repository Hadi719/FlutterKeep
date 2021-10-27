import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/note_model.dart';
import '../src/Util/screen_size_config.dart';

final _lightColors = [
  Colors.deepPurple,
  Colors.green.shade800,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class OldNoteCardWidget extends StatelessWidget {
  const OldNoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final timeDate = DateFormat('d MMM, y').format(note.createdTime);
    final timeHour = DateFormat('HH : mm').format(note.createdTime);
    final minHeight = getMinHeight(index);
    ScreenSizeConfig().init(context);
    return Stack(
      children: [
        Card(
          color: color,
          elevation: 10.0,
          margin: const EdgeInsets.fromLTRB(8, 20, 8, 8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(50.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: Container(
            width: ScreenSizeConfig.safeBlockHorizontal * 45,
            constraints: BoxConstraints(minHeight: minHeight),
            padding: const EdgeInsets.fromLTRB(20, 20, 8, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Column(
                    children: [
                      Text(
                        timeDate,
                        textScaleFactor: 1,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timeHour,
                        textScaleFactor: 1,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  note.title,
                  textScaleFactor: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 8,
          top: 0,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent, //white.withOpacity(0.2)
            child: Icon(
              Icons.assignment_outlined,
              size: ScreenSizeConfig.safeBlockHorizontal * 10,
              color: Colors.blueAccent,
            ),
          ),
        )
      ],
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
