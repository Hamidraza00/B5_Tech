
import 'package:order_booking_shop/Databases/DBHelperShopVisit_2nd.dart';
import '../../Models/OrderModels/ShopVisit_2ndModel.dart';





class ShopVisit_2ndRepository {

  DBHelperShopVisit_2nd dbHelpershopvisit_2nd = DBHelperShopVisit_2nd();

  Future<List<ShopVisit_2ndModel>> getShopVisit_2nd() async {
    var dbClient = await dbHelpershopvisit_2nd.db;
    List<Map> maps = await dbClient.query('shopVisit_2nd', columns: ['id','walkthrough', 'planogram' , 'signage' , 'productReviewed', 'imagePath' ]);
    List<ShopVisit_2ndModel> shopvisit_2nd = [];

    for (int i = 0; i < maps.length; i++) {
      shopvisit_2nd.add(ShopVisit_2ndModel.fromMap(maps[i]));
    }
    return shopvisit_2nd;
  }

  Future<int> add(ShopVisit_2ndModel shopvisit_2ndModel) async{
    var dbClient = await dbHelpershopvisit_2nd.db;

    return await dbClient.insert('shopVisit_2nd' , shopvisit_2ndModel.toMap());
  }

  Future<int> update(ShopVisit_2ndModel shopvisit_2ndModel) async{
    var dbClient = await dbHelpershopvisit_2nd.db;
    return await dbClient.update('shopVisit_2nd', shopvisit_2ndModel.toMap(),
        where: 'id=?', whereArgs: [shopvisit_2ndModel.id] );
  }

  Future<int> delete(int id) async{
    var dbClient = await dbHelpershopvisit_2nd.db;
    return await dbClient.delete('shopVisit_2nd',
        where: 'id=?', whereArgs: [id] );
  }
}



