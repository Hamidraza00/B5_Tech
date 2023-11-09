
import 'package:order_booking_shop/Models/ProductsModel.dart';

class OrderMasterModel {
  int? orderId;
  String? date;
  String? shopName;
  String? ownerName;
  String? phoneNo;
  String? brand;

  OrderMasterModel({

    this.orderId,
    this.date,
    this.shopName,
    this.ownerName,
    this.phoneNo,
    this.brand,
  });

  factory OrderMasterModel.fromMap(Map<dynamic, dynamic> json) {
    return OrderMasterModel(
      orderId: json['orderId'],
      date: json['date'],
      shopName: json['shopName'],
      ownerName: json['ownerName'],
      phoneNo: json['phoneNo'],
      brand: json['brand'],
    );
  }

  Map<String, dynamic> toMap() {
    return {

      'orderId': orderId,
      'date': date,
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