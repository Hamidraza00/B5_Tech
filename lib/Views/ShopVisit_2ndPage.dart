import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_booking_shop/Views/OrderBookingPage.dart';

import '../Databases/DBHelperShopVisit.dart';
import '../Models/OrderModels/ShopVisit_2ndModel.dart';
import '../View_Models/ShopVisit_2ndViewModel.dart';
import 'FinalOrderBookingPage.dart';


void main() {
  runApp(MaterialApp(
    home: ShopVisit_2ndPage(),
  ));
}

class ShopVisit_2ndPage extends StatefulWidget {
// Add the selectedBrand parameter

  @override
  _ShopVisit_2ndPageState createState() => _ShopVisit_2ndPageState();
}

class _ShopVisit_2ndPageState extends State<ShopVisit_2ndPage> {
  ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;
 int? shopvist_2ndId;
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  String feedbackText = '';



  @override
  Widget build(BuildContext context) {


    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final shopName = data['shopName'];
    final ownerName = data['ownerName'];
    final selectedBrandName = data['selectedBrandName'];
    final bookerName= data[ 'bookerName'];
    print(shopName);
    print(ownerName);
    print(selectedBrandName);
    print(bookerName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Title'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildRow('2-Performed Store Walkthrough', checkboxValue1, (bool? value) {
                  if (value != null) {
                    setState(() {
                      checkboxValue1 = value;
                    });
                  }
                }),
                buildRow('3-Update Store Planogram', checkboxValue2, (bool? value) {
                  if (value != null) {
                    setState(() {
                      checkboxValue2 = value;
                    });
                  }
                }),
                buildRow('4-Shelf tags and price signage check', checkboxValue3, (bool? value) {
                  if (value != null) {
                    setState(() {
                      checkboxValue3 = value;
                    });
                  }
                }),
                buildRow('5-Expiry date on product reviewed', checkboxValue4, (bool? value) {
                  if (value != null) {
                    setState(() {
                      checkboxValue4 = value;
                    });
                  }
                }),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final image = await _imagePicker.getImage(source: ImageSource.camera);

                    if (image != null) {
                      setState(() {
                        _imageFile = File(image.path);
                        // Store the image file path in the data map
                        data['imagePath'] = _imageFile!.path;
                      });
                      Fluttertoast.showToast(
                        msg: 'Image saved in variable: ${_imageFile!.path}',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('No image selected.'),
                      ));
                    }
                  },
                  child: Text('+ Add Photo'),
                ),

                SizedBox(height: 50),
                ElevatedButton(
                    onPressed: ()

                          async {
                            // Create a ShopVisit_2ndModel instance with checkbox values and other data
                            ShopVisit_2ndModel shopVisit_2ndModel = ShopVisit_2ndModel(
                              id: shopvist_2ndId,
                               walkthrough: checkboxValue1,
                                 planogram: checkboxValue2,
                                signage: checkboxValue3,
                              productReviewed: checkboxValue4,
                                );


                            // Add the ShopVisit_2ndModel to the database
                     await ShopVisitView_2ndModel().addShopVisit_2nd(shopVisit_2ndModel);

                            // Execute joinTables method before navigating to FinalOrderBookingPage
                     await DBHelperShopVisit().joinTables();

                     // Show toast message indicating successful data save
                            Fluttertoast.showToast(
                              msg: 'Data saved successfully',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );


                    // Navigate to FinalOrderBookingPage and pass the selected brand
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalOrderBookingPage(),
                        settings: RouteSettings(arguments: data),
                      ),
                    );
                  },
                  child: Text('+ Order Booking Form'),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Text('Feedback/ Special Note'),
                SizedBox(height: 20.0),
                // Feedback or Note Box
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Feedback or Note',
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                    onChanged: (text) {
                      setState(() {
                        feedbackText = text;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the ThirdPage
                  },
                  child: Text('Submit'),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(String text, bool value, void Function(bool?) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 14, color: Colors.black), // Set the font size here
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: Colors.white,
          activeColor: Colors.green,
        ),
      ],
    );
  }
}
