import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<Database> _initDatabase(String filepath) async {
    final dbPath = await getDatabasesPath();
    //TODO print call database location
    print('db location: ' + dbPath);
    final path = join(dbPath, filepath);

    return await openDatabase(path,
        version: 1, onCreate: _createDB, onConfigure: _onConfigure);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $notesTableName ( 
  ${NoteFields.noteId} $idType,
  ${NoteFields.title} $textType,
  ${NoteFields.time} $textType
  )
''');
    await db.execute('''
    CREATE TABLE $contentsTableName ( 
    ${NoteFields.contentId} $idType,
    ${NoteFields.contentNoteId} $intType,
    ${NoteFields.noteText} $textType,
    ${NoteFields.checkBox} $intType,
    ${NoteFields.isDone} $intType,
    FOREIGN KEY(${NoteFields.contentNoteId}) REFERENCES $notesTableName(${NoteFields.noteId})
    )
    ''');
  }

  Future _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future addNote(Note note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final noteId = await db.insert(notesTableName, note.toJson());
    //TODO print call Note ID from db.addNote
    print('Note ID form addNote in database:' + noteId.toString());
    final dbPath = await getDatabasesPath();
    //TODO print call database location
    print('db location: ' + dbPath);
    note.add(noteId: noteId);
    return noteId;
  }

  Future<Content> addContent(Content content) async {
    final db = await instance.database;

    final contentId = await db.insert(contentsTableName, content.toJson());
    //TODO print call: Content ID form db.addContent
    print('Content ID from addContent in database ' + contentId.toString());
    return content.add(contentId: contentId);
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

  Future<Content> readContent(int contentNoteId) async {
    final db = await instance.database;

    final maps = await db.query(
      contentsTableName,
      columns: NoteFields.contentsTableColumns,
      where: '${NoteFields.contentNoteId} = ?',
      whereArgs: [contentNoteId],
    );

    if (maps.isNotEmpty) {
      return Content.fromJson(maps.first);
    } else {
      throw Exception('Content with Note ID $contentNoteId not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

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
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateContent(Content content) async {
    final db = await instance.database;

    return db.update(
      contentsTableName,
      content.toJson(),
      where: '${NoteFields.contentNoteId} = ?',
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

  Future<int> deleteContent(int contentNoteId) async {
    final db = await instance.database;

    return await db.delete(
      contentsTableName,
      where: '${NoteFields.contentNoteId} = ?',
      whereArgs: [contentNoteId],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
