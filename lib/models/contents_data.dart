import 'package:flutter/foundation.dart';

import '../models/content_models.dart';

class ContentsData extends ChangeNotifier {
  List<Content> _contentList = [];

  List<Content> get getContentList => _contentList;

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
  void addContent(String noteText) {
    final content = Content(noteText: noteText);
    _contentList.add(content);
    notifyListeners();
  }
}
