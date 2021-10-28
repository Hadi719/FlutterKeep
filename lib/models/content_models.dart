const String contentsTableName = 'contents';

/// CONTENTS Table Columns name.
class ContentFields {
  static final List<String> contentsTableColumns = [
    contentId,
    contentNoteId,
    noteText,
    isDone,
  ];

  /// "contentId" Column in "contents" Table.
  static const contentId = 'contentId';

  /// "contentNoteId" Column in "contents" Table.
  static const contentNoteId = 'contentNoteId';

  /// "noteText" Column in "contents" Table.
  static const noteText = 'noteText';

  /// "isDone" Column in "contents" Table.
  static const isDone = 'isDone';
}

/// Content Model.
class Content {
  int? contentId;
  int? contentNoteId;
  String noteText;
  bool? isDone;

  Content({
    this.contentId,
    this.contentNoteId,
    this.noteText = '',
    this.isDone = false,
  });

  Content add({
    int? contentId,
    int? contentNoteId,
    String? noteText,
    bool? isDone,
  }) {
    return Content(
      contentId: contentId ?? this.contentId,
      contentNoteId: contentNoteId ?? this.contentNoteId,
      noteText: noteText ?? this.noteText,
      isDone: isDone ?? this.isDone,
    );
  }

  static Content fromJson(Map<String, Object?> json) {
    return Content(
      contentId: json[ContentFields.contentId] as int?,
      contentNoteId: json[ContentFields.contentNoteId] as int?,
      noteText: json[ContentFields.noteText] as String,
      isDone: json[ContentFields.isDone] == 1,
    );
  }

  Map<String, Object?> toJson() => {
        ContentFields.contentId: contentId,
        ContentFields.contentNoteId: contentNoteId,
        ContentFields.noteText: noteText,
        ContentFields.isDone: isDone == true ? 1 : 0,
      };
}
