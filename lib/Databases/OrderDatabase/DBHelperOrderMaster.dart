import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../../API/ApiServices.dart';
import '../../Models/OrderModels/OrderDetailsModel.dart';
import '../../Models/OrderModels/OrderMasterModel.dart';
import 'package:nanoid/nanoid.dart';

class DBHelperOrderMaster{

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
    String path = join(documentDirectory.path,'ordermaster.db');
    var db = openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version) async {
    db.execute(
        "CREATE TABLE orderMaster (orderId INTEGER PRIMARY KEY NOT NULL, date TEXT, shopName TEXT, ownerName TEXT, phoneNo TEXT, brand TEXT, userId TEXT)");


    await db.execute('''
      CREATE TABLE order_details(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_master_id INTEGER,
        productName TEXT,
        quantity INTEGER,
        price INTEGER,
        amount INTEGER,
        FOREIGN KEY (order_master_id) REFERENCES orderMaster(orderId)
      )
    ''');
  }

  Future<void> addOrderDetails(List<OrderDetailsModel> orderDetailsList) async {
    final db = await _db;
    for (var orderDetails in orderDetailsList) {
      await db?.insert('order_details', orderDetails.toMap());
    }
  }

  Future<List<Map<String, dynamic>>?> getOrderMasterDB() async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>> products = await db.query('orderMaster');
      return products;
    } catch (e) {
      print("Error retrieving products: $e");
      return null;
    }
  }

  Future<void> postMasterTable() async {
    final Database db = await initDatabase();
    final ApiServices api = ApiServices();
    try {
      final products = await db.rawQuery('select * from orderMaster');
      var count = 0;
      for(var i in products){
        print(i.toString());
        count++;
        var result = await api.masterPost(i, 'https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/ordermaster/post');
        if(result == true){
          db.rawQuery('DELETE FROM orderMaster WHERE orderId = ${i['orderId']}');
        }
      }
    } catch (e) {
      print("ErrorRRRRRRRRR: $e");
      return null;
    }
  }
}

