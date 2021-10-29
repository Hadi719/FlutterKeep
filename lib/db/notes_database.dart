import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/content_models.dart';
import '../models/note_model.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase('notes.db');
    return _database!;
  }

  Future<Database> _initDatabase(String databaseName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);

    return await openDatabase(path,
        version: 1, onCreate: _createDB, onConfigure: _onConfigure);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const intType = 'INTEGER';

    await db.execute('''
CREATE TABLE $notesTableName ( 
  ${NoteFields.noteId} $idType,
  ${NoteFields.title} $textType,
  ${NoteFields.isCheckBox} $intType,
  ${NoteFields.time} $textType
  )
''');
    await db.execute('''
    CREATE TABLE $contentsTableName ( 
    ${ContentFields.contentId} $idType,
    ${ContentFields.contentNoteId} $intType,
    ${ContentFields.noteText} $textType,
    ${ContentFields.isDone} $intType,
    FOREIGN KEY(${ContentFields.contentNoteId}) REFERENCES $notesTableName(${NoteFields.noteId})
    )
    ''');
  }

  Future _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future addNote(Note note) async {
    final db = await instance.database;

    final noteId = await db.insert(
      notesTableName,
      note.toJson(),
    );
    return noteId;
  }

  Future addContent(Content content) async {
    final db = await instance.database;

    final contentId = await db.insert(contentsTableName, content.toJson());
    content.add(contentId: contentId);
    return contentId;
  }

  Future<Note> readNote(int noteId) async {
    final db = await instance.database;

    final maps = await db.query(
      notesTableName,
      columns: NoteFields.notesTableColumns,
      where: '${NoteFields.noteId} = ?',
      whereArgs: [noteId],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('Note ID $noteId not found');
    }
  }

  Future<List<Content>> readContent(int contentNoteId) async {
    final db = await instance.database;

    final result = await db.query(
      contentsTableName,
      columns: ContentFields.contentsTableColumns,
      where: '${ContentFields.contentNoteId} = ?',
      whereArgs: [contentNoteId],
    );

    if (result.isNotEmpty) {
      List<Content> ourContents =
          result.map((json) => Content.fromJson(json)).toList();
      print(
          'db.readContent: Text[0]: ${ourContents[0].noteText} isDone: ${ourContents[0].isDone}');
      return ourContents;
    } else {
      throw Exception('Contents with Note ID $contentNoteId not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${NoteFields.time} ASC';

    final result = await db.query(notesTableName, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Content>> readAllContents() async {
    final db = await instance.database;

    final result = await db.query(contentsTableName);

    return result.map((json) => Content.fromJson(json)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await instance.database;

    return db.update(
      notesTableName,
      note.toJson(),
      where: '${NoteFields.noteId} = ?',
      whereArgs: [note.noteId],
    );
  }

  Future<int> updateContent(Content content) async {
    final db = await instance.database;

    return db.update(
      contentsTableName,
      content.toJson(),
      where: '${ContentFields.contentNoteId} = ?',
      whereArgs: [content.contentNoteId],
    );
  }

  Future<int> deleteNote(int noteId) async {
    final db = await instance.database;

    return await db.delete(
      notesTableName,
      where: '${NoteFields.noteId} = ?',
      whereArgs: [noteId],
    );
  }

  Future<int> deleteContents(int contentNoteId) async {
    final db = await instance.database;

    return await db.delete(
      contentsTableName,
      where: '${ContentFields.contentNoteId} = ?',
      whereArgs: [contentNoteId],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
