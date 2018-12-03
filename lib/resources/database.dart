import 'package:luharitrip/models/item_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';


class TravelDatabase {
  static final TravelDatabase _instance = TravelDatabase._internal();

  factory TravelDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  TravelDatabase._internal();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""CREATE TABLE Travels(id INTEGER PRIMARY KEY,
              title TEXT NOT NULL, 
              link TEXT NOT NULL,
              date TEXT NOT NULL,
              provider TEXT NOT NULL,
              destination_id INTEGER
              )""");

    print("Database was Created!");
  }

  Future<List<TravelItem>> getTravels() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Movies");
    return res.map((m) => TravelItem.fromDb(m)).toList();
  }

  Future<TravelItem> getMovie(String id) async {
    var dbClient = await db;
    var res = await dbClient.query("Travels", where: "id = ?", whereArgs: [id]);
    if (res.length == 0) return null;
    return TravelItem.fromDb(res[0]);
  }

  Future<int> addMovie(TravelItem movie) async {
    var dbClient = await db;
    try {
      int res = await dbClient.insert("Travels", movie.toMap());
      print("Travel added $res");
      return res;
    } catch (e) {
      int res = await updateMovie(movie);
      return res;
    }
  }

  Future<int> updateMovie(TravelItem movie) async {
    var dbClient = await db;
    int res = await dbClient.update("Travels", movie.toMap(),
        where: "id = ?", whereArgs: [movie.id]);
    print("Travel updated $res");
    return res;
  }

  Future<int> deleteMovie(String id) async {
    var dbClient = await db;
    var res = await dbClient.delete("Travels", where: "id = ?", whereArgs: [id]);
    print("Travel deleted $res");
    return res;
  }

  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }
}
