const String notesTableName = 'notes';
const String contentsTableName = 'contents';

class NoteFields {
  /// NOTES Table Columns.
  static final List<String> notesTableColumns = [
    noteId,
    title,
    time,
  ];

  /// CONTENTS Table Columns.
  static final List<String> contentsTableColumns = [
    contentId,
    contentNoteId,
    noteText,
    checkBox,
    isDone,
  ];

  /// "noteId" Column in "notes" Table.
  static const noteId = 'noteId';

  /// "title" Column in "notes" Table.
  static const title = 'title';

  /// "time" Column in "notes" Table.
  static const time = 'time';

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

/// Note Model.
class Note {
  final int? noteId;
  final String title;
  final DateTime createdTime;

  const Note({
    this.noteId,
    required this.title,
    required this.createdTime,
  });

  Note add({
    int? noteId,
    String? title,
    DateTime? createdTime,
  }) {
    return Note(
      noteId: noteId ?? this.noteId,
      title: title ?? this.title,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  static Note fromJson(Map<String, Object?> json) => Note(
        noteId: json[NoteFields.noteId] as int?,
        title: json[NoteFields.title] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.noteId: noteId,
        NoteFields.title: title,
        NoteFields.time: createdTime.toIso8601String(),
      };
}

/// Content Model.
class Content {
  final int? contentId;
  final int? contentNoteId;
  final String noteText;
  final bool checkBox;
  final bool isDone;

  const Content({
    this.contentId,
    required this.contentNoteId,
    required this.noteText,
    required this.checkBox,
    required this.isDone,
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

  static Content fromJson(Map<String, Object?> json) => Content(
        contentId: json[NoteFields.contentId] as int?,
        contentNoteId: json[NoteFields.contentNoteId] as int?,
        noteText: json[NoteFields.noteText] as String,
        checkBox: json[NoteFields.checkBox] == 1,
        isDone: json[NoteFields.isDone] == 1,
      );

  Map<String, Object?> toJson() => {
        NoteFields.contentId: contentId,
        NoteFields.contentNoteId: contentNoteId,
        NoteFields.noteText: noteText,
        NoteFields.checkBox: checkBox == true ? 1 : 0,
        NoteFields.isDone: isDone == true ? 1 : 0,
      };
}
