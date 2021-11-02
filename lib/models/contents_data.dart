import 'package:flutter/foundation.dart';

import '../models/content_models.dart';

class ContentsData extends ChangeNotifier {
  final List<Content> _contentList = [];
  final List<Content> _trueContentsList = [];
  final List<Content> _falseContentsList = [];

  List<Content> get getContentList => _contentList;
  List<Content> get getTrueContentList => _trueContentsList;
  List<Content> get getFalseContentList => _falseContentsList;

  int get getContentsListLength => _contentList.length;

  get clearList {
    // _contentList.clear();
    _contentList.removeRange(0, _contentList.length);
  }

  void updateContent(int index, Content newContent) {
    _contentList[index] = newContent;
    notifyListeners();
  }

  /// Add content to ContentsData._contentList
  void addContent(String noteText, bool? isDone) {
    final content = Content(
      noteText: noteText,
      isDone: isDone,
    );
    _contentList.add(content);
    if (isDone!) {
      _trueContentsList.add(content);
    } else {
      _falseContentsList.add(content);
    }
    notifyListeners();
  }
}
