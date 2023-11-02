import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_booking_shop/API/ApiServices.dart';
import 'package:order_booking_shop/Databases/OrderDatabase/DBHelperProducts.dart';
import '../Models/ProductsModel.dart';
import 'OrderMasterList.dart';
import '../Models/OrderModels/OrderMasterModel.dart';
import '../View_Models/OrderViewModels/OrderDetailsViewModel.dart';
import '../View_Models/OrderViewModels/OrderMasterViewModel.dart';
import '../View_Models/OrderViewModels/ProductsViewModel.dart';

class NewOrderBookingPage extends StatefulWidget {
  const NewOrderBookingPage({Key? key}) : super(key: key);

  @override
  State<NewOrderBookingPage> createState() => _NewOrderBookingPageState();
}

void main() {
  runApp(GetMaterialApp(
    home: Scaffold(
      body: NewOrderBookingPage(),
    ),
  ));
}

class _NewOrderBookingPageState extends State<NewOrderBookingPage> {
  final ordermasterViewModel = Get.put(OrderMasterViewModel());
  final orderdetailsViewModel = Get.put(OrderDetailsViewModel());
  final productsViewModel = Get.put(ProductsViewModel());

  final shopNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final brandController = TextEditingController();


  final api = ApiServices();

  int? ordermasterId;
  int? orderdetailsId;
  int? productsId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Booking'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildTextField('Shop Name', shopNameController),
            buildTextField('Owner Name', ownerNameController),
            buildTextField('Phone No', phoneNoController),
            buildTextField('Brand', brandController),
            SizedBox(height: 10),
            buildDropdown(), // Dropdown widget added
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  if (shopNameController.text.isNotEmpty) {
                    ordermasterViewModel.addOrderMaster(OrderMasterModel(
                      orderId: ordermasterId,
                      shopName: shopNameController.text,
                      ownerName: ownerNameController.text,
                      phoneNo: phoneNoController.text,
                      brand: brandController.text,
                    ));

                    senddata();

                    shopNameController.text = "";
                    ownerNameController.text = "";
                    phoneNoController.text = "";
                    brandController.text = "";

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderMasterList(
                            savedOrderMasterData:
                            ordermasterViewModel.allOrderMaster),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildDropdown() {
    return Obx(() {
      final List<ProductsModel> allProducts = productsViewModel.allProducts;

      return DropdownButton<ProductsModel>(
        value: productsViewModel.selectedProduct.value, // Access the selected product
        onChanged: (ProductsModel? newValue) {
          // Set the selected product directly
          productsViewModel.selectedProduct.value = newValue;
        },
        items: allProducts.map<DropdownMenuItem<ProductsModel>>((ProductsModel product) {
          return DropdownMenuItem<ProductsModel>(
            value: product,
            child: Text(product.product_name ?? 'No Name'),
          );
        }).toList(),
      );
    });
  }


  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> senddata() async {
    var mastertable = OrderMasterModel();
    mastertable.orderId = ordermasterId;
    mastertable.shopName = shopNameController.text;
    mastertable.ownerName = ownerNameController.text;
    mastertable.phoneNo = phoneNoController.text;
    mastertable.brand = brandController.text;

    var response = await api.postApi(
        mastertable.toMap(),
        'https://webhook.site/b34592b6-fd07-4869-aa52-e76516683525');
    print(response.toMap());
  }
}
