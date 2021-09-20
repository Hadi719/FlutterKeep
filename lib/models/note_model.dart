final String tableName = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, title, content, time
  ];

  static final id = '_id';
  static final title = 'title';
  static final content = 'content';
  static final time = 'time';
}

class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdTime,
  });
  Note copy({
    int? id,
    String? title,
    String? content,
    DateTime? createdTime,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        content: json[NoteFields.content] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.content: content,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
