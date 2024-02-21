import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> get database async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'pokemon_database.db');
    return openDatabase(databasePath);
  }
}
