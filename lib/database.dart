import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> createDatabase() async {
    String databasePath = await getDatabasesPath();
    Database database = await openDatabase(join(databasePath, "note_database.db"),
        onCreate: (db, version) => db.execute(
            "CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)"),
        version: 1);
    return database;
  }
}
