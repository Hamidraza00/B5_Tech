
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperShopVisit_2nd {

  static Database? _db;

  Future<Database> get db async{
    if(_db != null)
    {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  Future<Database>initDatabase() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'shopvisit_2nd.db');
    var db = openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version) async {
    db.execute(
        "CREATE TABLE shopVisit_2nd (id INTEGER PRIMARY KEY NOT NULL, walkthrough TEXT, planogram TEXT,signage TEXT, productReviewed TEXT, imagePath TEXT)"
    );
  }
}

