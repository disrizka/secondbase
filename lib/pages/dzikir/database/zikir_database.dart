import 'package:secondbase/pages/dzikir/model/zikir_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ZikirDatabase {
  static final ZikirDatabase instance = ZikirDatabase._init();
  static Database? _database;

  ZikirDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('zikir.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE zikir (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        jenis TEXT,
        jumlah INTEGER,
        pesan TEXT
      )
    ''');
  }

  Future<void> insertZikir(Zikir zikir) async {
    final db = await instance.database;
    await db.insert('zikir', zikir.toMap());
  }

  Future<List<Zikir>> getAllZikir() async {
    final db = await instance.database;
    final result = await db.query('zikir');
    return result.map((e) => Zikir.fromMap(e)).toList();
  }

  Future<void> deleteZikir(int id) async {
    final db = await instance.database;
    await db.delete('zikir', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateZikir(Zikir zikir) async {
    final db = await instance.database;
    await db.update(
      'zikir',
      zikir.toMap(),
      where: 'id = ?',
      whereArgs: [zikir.id],
    );
  }
}
