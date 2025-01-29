import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._instance();
  static Database? _db;
  final _tableName = "notes";
  final _idColumn = "id";
  final _titleColumn = "title";
  final _descriptionColumn = "description";

  DatabaseService._instance();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirectoryPath = await getDatabasesPath();
    final databasePath = join(databaseDirectoryPath, "notes_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_tableName ($_idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $_titleColumn TEXT, $_descriptionColumn TEXT);
        ''');
      },
    );
    return database;
  }

  Future<void> addNote({required String title, required String description}) async {
    Map<String, dynamic> note = {
      _titleColumn: title,
      _descriptionColumn: description,
    };
    final db = await database;
    await db.insert(_tableName, note);
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    return db.query(_tableName);
  }
}
