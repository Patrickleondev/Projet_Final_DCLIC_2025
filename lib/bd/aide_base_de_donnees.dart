import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AideBaseDeDonnees {
  static final AideBaseDeDonnees instance = AideBaseDeDonnees._init();
  static Database? _database;

  AideBaseDeDonnees._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notezone.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _creerDB);
  }

  Future _creerDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE utilisateurs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom_utilisateur TEXT UNIQUE,
        mot_de_passe TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT,
        contenu TEXT,
        date_creation TEXT,
        utilisateur_id INTEGER,
        FOREIGN KEY(utilisateur_id) REFERENCES utilisateurs(id)
      )
    ''');
  }
}
