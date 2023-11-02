import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperProducts{

  static Database? _db;

  Future<Database> get db async{
    if(_db != null)
    {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'products.db');
    var db = openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version){
    db.execute("CREATE TABLE products(product_code TEXT, product_name TEXT, uom TEXT ,price TEXT)"
    );
  }

  Future<bool> insertProductsAll(List<dynamic> dataList) async {
    final Database db = await initDatabase();
    try {
      for (var data in dataList) {
        await db.insert('products', data);
      }
      return true;
    } catch (e) {
      print("Error inserting product data: ${e.toString()}");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> getAllProducts() async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>> products = await db.query('products');
      return products;
    } catch (e) {
      print("Error retrieving products: $e");
      return null;
    }
  }




}


