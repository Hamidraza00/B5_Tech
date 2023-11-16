class ShopVisit_2ndModel {
  int? id;
  bool? walkthrough;
  bool? planogram;
  bool? signage;
  bool? productReviewed;
  String? imagePath; // Add this line to store the image path

  ShopVisit_2ndModel({
    this.id,
    this.walkthrough,
    this.planogram,
    this.signage,
    this.productReviewed,
    this.imagePath,
  });

  factory ShopVisit_2ndModel.fromMap(Map<dynamic, dynamic> json) {
    return ShopVisit_2ndModel(
      id: json['id'],
      walkthrough: json['walkthrough'] == 1 || json['walkthrough'] == 'true' || json['walkthrough'] == true,
      planogram: json['planogram'] == 1 || json['planogram'] == 'true' || json['planogram'] == true,
      signage: json['signage'] == 1 || json['signage'] == 'true' || json['signage'] == true,
      productReviewed: json['productReviewed'] == 1 || json['productReviewed'] == 'true' || json['productReviewed'] == true,
      imagePath: json['imagePath'], // Add this line to get the imagePath from the database
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'walkthrough': walkthrough == true ? 1 : 0,
      'planogram': planogram == true ? 1 : 0,
      'signage': signage == true ? 1 : 0,
      'productReviewed': productReviewed == true ? 1 : 0,
      'imagePath': imagePath, // Add this line to store the imagePath in the database
    };
  }
}
