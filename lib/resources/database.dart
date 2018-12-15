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
    String path = join(documentsDirectory.path, "luharitrip.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""CREATE TABLE Travels(id INTEGER PRIMARY KEY,
              title TEXT NOT NULL, 
              link TEXT NOT NULL,
              date TEXT NOT NULL,
              provider TEXT NOT NULL,
              destination_id INTEGER,
              background_id integer
              )""");

    print("Database was Created!");
  }

  Future<ItemModelDB> getTravels() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Travels");
    return ItemModelDB.fromDB(res);
  }

  Future<TravelItem> getTravel(String id) async {
    var dbClient = await db;
    var res = await dbClient.query("Travels", where: "id = ?", whereArgs: [id]);
    if (res.length == 0) return null;
    return TravelItem.fromDb(res[0]);
  }

  Future<int> addTravel(TravelItem travel) async {
    var dbClient = await db;
    int res = await dbClient.insert("Travels", travel.toMap());
    print("Travel added $res");
    return res;
  }


  Future<int> deleteTravel(int id) async {
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
