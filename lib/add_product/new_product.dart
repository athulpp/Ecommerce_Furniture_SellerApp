import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:seller/control/bottom_navigation.dart';
import 'package:seller/control/controller.dart';
import 'package:seller/model/product_model.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);
  TextEditingController _productName = TextEditingController();
  TextEditingController _productDescripiton = TextEditingController();
  TextEditingController _prodcutQuantity = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Uint8List? imag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.black,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          // if (imag!.isEmpty) {
                          //   return;
                          // }
                          imag = await pickImage();
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Add Image',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Product Informations',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _productName,
                        onSaved: (value) {
                          _productName.text = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Product Name";
                          }
                        },
                        decoration: InputDecoration(hintText: 'Product Name'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _productDescripiton.text = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Product Descipition required';
                          }
                        },
                        controller: _productDescripiton,
                        decoration:
                            InputDecoration(hintText: 'Product Descripition'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _productprice.text = value!;
                        },
                        controller: _productprice,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'product Price is Required';
                          }
                        },
                        decoration: InputDecoration(hintText: 'Product Price'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _prodcutQuantity.text = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Product Quantity is Required';
                          }
                        },
                        controller: _prodcutQuantity,
                        decoration:
                            InputDecoration(hintText: 'Product Quantity'),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic imgUrl = await selectImage();

                      controller.Addproduct(
                          productId: uuid.v4(),
                          productName: _productName.text,
                          productDes: _productDescripiton.text,
                          productQuantity: _prodcutQuantity.text,
                          productPrice: _productprice.text,
                          file: imgUrl);
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => BottomNavigation()))
                          .whenComplete;
                      Fluttertoast.showToast(msg: "Product Added Sucessfully!");
                      // var alertStyle = AlertStyle(
                      //   animationType: AnimationType.fromTop,
                      //   isCloseButton: false,
                      //   isOverlayTapDismiss: false,
                      //   descStyle: TextStyle(fontWeight: FontWeight.bold),
                      //   descTextAlign: TextAlign.start,
                      //   animationDuration: Duration(milliseconds: 400),
                      //   alertBorder: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(0.0),
                      //     side: BorderSide(
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      //   titleStyle: TextStyle(
                      //     color: Colors.red,
                      //   ),
                      //   alertAlignment: Alignment.topRight,
                      // );
                      // Alert(
                      //   context: context,
                      //   style: alertStyle,
                      //   type: AlertType.success,
                      //   title: "Product Added Sucessfully",
                      //   desc: "Added",
                      //   // buttons: [
                      //   //   DialogButton(
                      //   //     child: Text(
                      //   //       "COOL",
                      //   //       style:
                      //   //           TextStyle(color: Colors.white, fontSize: 20),
                      //   //     ),
                      //   //     onPressed: () => Navigator.pop(context),
                      //   //     color: Color.fromRGBO(0, 179, 134, 1.0),
                      //   //     radius: BorderRadius.circular(0.0),
                      //   //   ),
                      //   // ],
                      // ).show();
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // addProduct() async {
  //   if (_productName.text.trim().isEmpty &&
  //       _productDescripiton.text.trim().isEmpty &&
  //       _productprice.text.trim().isEmpty &&
  //       _prodcutQuantity.text.trim().isEmpty) {
  //     return;
  //   }
  //   Product model=Product(productName: _productName.text, ProductDescripition:_productDescripiton.text, prdouctPrice:_productprice.text, productQuantity:_prodcutQuantity.text);

  //   await Controller.Addproduct(productName: _productName.text,productDes: _productDescripiton.text,productQuantity: _prodcutQuantity.text,productPrice: _productprice.text,file: selectImage());

  // Product product = Product(
  //   productName: _productName.text,
  //   ProductDescripition: _productDescripiton.text,
  //   prdouctPrice: _productprice.text,
  //   productQuantity: _prodcutQuantity.text,
  //   productImage: ,
  // );
  // }

  pickImage() async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file.readAsBytes();
    }
    print('No image se');
  }

  Future<String> selectImage() async {
    // Uint8List im = await pickImage();
    String _image = await controller.uploadImageToStorage('prod', imag!);
    return _image;
  }

  // Future<String> uploadImageToStorage(
  //     String childName, Uint8List _image, bool isPost) async {
  //   Reference ref =
  //       _storage.ref().child(childName).child(_auth.currentUser!.uid);

  //   UploadTask uploadTask = ref.putData(_image);
  //   await uploadTask;

  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadURL = await snapshot.ref.getDownloadURL();
  //   return downloadURL;
  // }
}
