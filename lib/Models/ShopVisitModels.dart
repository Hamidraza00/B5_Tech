
import 'package:order_booking_shop/Models/ProductsModel.dart';

class ShopVisitModel {
  int? id;
  String? date;
  String? shopName;
  String? bookerName;
  String? brand;
  String? itemDescription;
  String? quantity;

  ShopVisitModel({

    this.id,
    this.date,
    this.shopName,
    this.bookerName,
    this.itemDescription,
    this.brand,
    this. quantity,
  });

  factory ShopVisitModel.fromMap(Map<dynamic, dynamic> json) {
    return ShopVisitModel(
      id: json['id'],
      date: json['date'],
      shopName: json['shopName'],
      bookerName: json['bookerName'],
      itemDescription: json['itemDescription'],
      brand: json['brand'],
      quantity: json['quantity']
    );
  }

  Map<String, dynamic> toMap() {
    return {

      'id': id,
      'date': date,
      'shopName': shopName,
      'ownerName': bookerName,
      'itemDescription': itemDescription,
      'brand': brand,
      'quantity': quantity,
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