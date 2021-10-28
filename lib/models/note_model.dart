const String notesTableName = 'notes';

/// NOTES Table Columns name.
class NoteFields {
  static final List<String> notesTableColumns = [
    noteId,
    title,
    isCheckBox,
    time,
  ];

  /// "noteId" Column in "notes" Table.
  static const noteId = 'noteId';

  /// "title" Column in "notes" Table.
  static const title = 'title';

  /// "isCheckBox" Column in "notes" Table.
  static const isCheckBox = 'checked';

  /// "time" Column in "notes" Table.
  static const time = 'time';
}

/// Note Model.
class Note {
  final int? noteId;
  final String title;
  final bool isCheckBox;
  final DateTime time;

  const Note({
    this.noteId,
    required this.title,
    this.isCheckBox = false,
    required this.time,
  });

  Note add({
    int? noteId,
    required String title,
    bool? isCheckBox,
    DateTime? time,
  }) {
    return Note(
      noteId: noteId ?? this.noteId,
      title: title,
      isCheckBox: isCheckBox ?? this.isCheckBox,
      time: time ?? this.time,
    );
  }

  static Note fromJson(Map<String, Object?> json) => Note(
        noteId: json[NoteFields.noteId] as int?,
        title: json[NoteFields.title] as String,
        isCheckBox: json[NoteFields.isCheckBox] == 1,
        time: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.noteId: noteId,
        NoteFields.title: title,
        NoteFields.isCheckBox: isCheckBox == true ? 1 : 0,
        NoteFields.time: time.toIso8601String(),
      };
}
