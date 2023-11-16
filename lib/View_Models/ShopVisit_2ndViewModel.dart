import 'package:get/get.dart';
import 'package:order_booking_shop/Repositories/OrderRepository/ShopVisit_2ndRepository.dart';
import '../Models/OrderModels/ShopVisit_2ndModel.dart';


class ShopVisitView_2ndModel extends GetxController{

  var allShopVisit_2nd = <ShopVisit_2ndModel>[].obs;
  ShopVisit_2ndRepository shopvisit_2ndRepository = ShopVisit_2ndRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllShopVisit_2nd();
  }

  fetchAllShopVisit_2nd() async{
    var shopvisit_2nd = await shopvisit_2ndRepository.getShopVisit_2nd();
    allShopVisit_2nd.value = shopvisit_2nd;
  }

  addShopVisit_2nd(ShopVisit_2ndModel shopvisit_2ndModel){
    shopvisit_2ndRepository.add(shopvisit_2ndModel);
    fetchAllShopVisit_2nd();
  }

  updateShopVisit(ShopVisit_2ndModel shopvisit_2ndModel){
    shopvisit_2ndRepository.update(shopvisit_2ndModel);
    fetchAllShopVisit_2nd();
  }

  deleteShopVisit(int id){
    shopvisit_2ndRepository.delete(id);
    fetchAllShopVisit_2nd();
  }


}