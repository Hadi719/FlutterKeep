const String contentsTableName = 'contents';

/// CONTENTS Table Columns name.
class ContentFields {
  static final List<String> contentsTableColumns = [
    contentId,
    contentNoteId,
    noteText,
    checkBox,
    isDone,
  ];

  /// "contentId" Column in "contents" Table.
  static const contentId = 'contentId';

  /// "contentNoteId" Column in "contents" Table.
  static const contentNoteId = 'contentNoteId';

  /// "noteText" Column in "contents" Table.
  static const noteText = 'noteText';

  /// "checkBox" Column in "contents" Table.
  static const checkBox = 'checked';

  /// "isDone" Column in "contents" Table.
  static const isDone = 'isDone';
}

/// Content Model.
class Content {
  int? contentId;
  int? contentNoteId;
  String noteText;
  bool? checkBox;
  bool? isDone;

  Content({
    this.contentId,
    this.contentNoteId,
    this.noteText = '',
    this.checkBox,
    this.isDone,
  });

  Content add({
    int? contentId,
    int? contentNoteId,
    String? noteText,
    bool? checkBox,
    bool? isDone,
  }) {
    return Content(
      contentId: contentId ?? this.contentId,
      contentNoteId: contentNoteId ?? this.contentNoteId,
      noteText: noteText ?? this.noteText,
      checkBox: checkBox ?? this.checkBox,
      isDone: isDone ?? this.isDone,
    );
  }

  static Content fromJson(Map<String, Object?> json) {
    return Content(
      contentId: json[ContentFields.contentId] as int?,
      contentNoteId: json[ContentFields.contentNoteId] as int?,
      noteText: json[ContentFields.noteText] as String,
      checkBox: json[ContentFields.checkBox] == 1,
      isDone: json[ContentFields.isDone] == 1,
    );
  }

  Map<String, Object?> toJson() => {
        ContentFields.contentId: contentId,
        ContentFields.contentNoteId: contentNoteId,
        ContentFields.noteText: noteText,
        ContentFields.checkBox: checkBox == true ? 1 : 0,
        ContentFields.isDone: isDone == true ? 1 : 0,
      };
}
