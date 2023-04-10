import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static const tableName = 'places';

  static Future<sql.Database> database() async {
    final String dbPath = await sql.getDatabasesPath();
    final String dbFile = path.join(dbPath, '$tableName.db');

    return sql.openDatabase(
      dbFile,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName (id TEXT PRIMARY KEY, title TEXT,'
          ' image TEXT, latitude REAL, longitude REAL, address TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await DbUtil.database();

    return db.query(table);
  }
}
