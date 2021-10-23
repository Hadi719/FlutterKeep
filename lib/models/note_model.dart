const String notesTableName = 'notes';

/// NOTES Table Columns name.
class NoteFields {
  static final List<String> notesTableColumns = [
    noteId,
    title,
    time,
  ];

  /// "noteId" Column in "notes" Table.
  static const noteId = 'noteId';

  /// "title" Column in "notes" Table.
  static const title = 'title';

  /// "time" Column in "notes" Table.
  static const time = 'time';
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
    required String title,
    DateTime? createdTime,
  }) {
    return Note(
      noteId: noteId ?? this.noteId,
      title: title,
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
