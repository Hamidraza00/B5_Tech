
import 'package:order_booking_shop/Models/ProductsModel.dart';

class OrderMasterModel {
  int? orderId;
  String? shopName;
  String? ownerName;
  String? phoneNo;
  String? brand;

  OrderMasterModel({
    this.orderId,
    this.shopName,
    this.ownerName,
    this.phoneNo,
    this.brand, ProductsModel? product,
  });

  factory OrderMasterModel.fromMap(Map<dynamic, dynamic> json) {
    return OrderMasterModel(
      orderId: json['orderId'],
      shopName: json['shopName'],
      ownerName: json['ownerName'],
      phoneNo: json['phoneNo'],
      brand: json['brand'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'shopName': shopName,
      'ownerName': ownerName,
      'phoneNo': phoneNo,
      'brand': brand,
    };
  }
}
//
//   Map<String, dynamic> toNewMap() {
//     return {
//       'shopName': shopName,
//       'ownerName': ownerName,
//       'phoneNo': phoneNo,
//       'brand': brand,
//     };
//   }
// }