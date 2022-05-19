import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';

import 'package:seller/control/bottom_navigation.dart';
import 'package:seller/control/controller.dart';

import 'package:uuid/uuid.dart';

var uuid = Uuid();

class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);
  TextEditingController _productName = TextEditingController();
  TextEditingController _productDescripiton = TextEditingController();
  TextEditingController _prodcutQuantity = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  // TextEditingController _productCategory = TextEditingController();
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
                      child: Row(children: [
                        IconButton(
                          onPressed: () async {
                            await pickImage();
                            // controller.image = imag;

                            // // controller.update();
                            // print(controller.image);
                            // print(imag);
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Image',
                              style: GoogleFonts.adventPro(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 90,
                            ),
                            GetBuilder<Controller>(
                                // id: 'product',
                                builder: (controller) {
                              print(
                                  '${controller.image == null}this is null era');
                              return Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  image: controller.image == null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'))
                                      : DecorationImage(
                                          image:
                                              MemoryImage(controller.image!)),
                                ),
                              );
                            })
                          ],
                        )
                      ]))),

              const SizedBox(
                height: 20,
              ),
              Text(
                'Product Informations',
                style: GoogleFonts.adventPro(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _productName,
                        style: GoogleFonts.habibi(fontSize: 18),
                        onSaved: (value) {
                          _productName.text = value!;
                        },
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{4,}$');
                          if (value!.isEmpty) {
                            return "Please Enter Product Name";
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Minum 4 lettters required");
                          }
                        },
                        decoration: InputDecoration(hintText: 'Product Name'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: GoogleFonts.habibi(fontSize: 18),
                        onSaved: (value) {
                          _productDescripiton.text = value!;
                        },
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{20,}$');
                          if (value!.isEmpty) {
                            return 'Product Descipition required';
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Minum 20 lettters required");
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
                        style: GoogleFonts.habibi(fontSize: 18),
                        keyboardType: TextInputType.number,
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
                        style: GoogleFonts.habibi(fontSize: 18),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _prodcutQuantity.text = value!;
                        },
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{1,}$');
                          if (value!.isEmpty) {
                            return 'Product Quantity is Required';
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Minimum 1 product required)");
                          }
                        },
                        controller: _prodcutQuantity,
                        decoration:
                            InputDecoration(hintText: 'Product Quantiy'),
                      ),
                      // TextFormField(
                      //   onSaved: (value) {
                      //     _productCategory.text = value!;
                      //   },
                      //   validator: (value) {
                      //     RegExp regex = new RegExp(r'^.{4,}$');
                      //     if (value!.isEmpty) {
                      //       return 'Product Category is Required';
                      //     }
                      //     if (!regex.hasMatch(value)) {
                      //       return ("Minimum 4 letters  required)");
                      //     }
                      //   },
                      //   controller: _prodcutQuantity,
                      //   decoration:
                      //       InputDecoration(hintText: 'Product Category'),
                      // ),
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

                      await controller.Addproduct(
                          productId: uuid.v4(),
                          productName: _productName.text,
                          productDes: _productDescripiton.text,
                          productQuantity: _prodcutQuantity.text,
                          productPrice: _productprice.text,
                          // productCategory: _productCategory.text,
                          file: imgUrl);
                      // controller.image = null;
                      controller.image == null;
                      // Get.offAll(() => BottomNavigation());
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => BottomNavigation(
                                    currentIndex: 0,
                                  )))
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
                  child: Text(
                    'Save',
                    style: GoogleFonts.adamina(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Obx(
              //   () => imag != null
              //       ? Image.memory(imag!, width: 100, height: 100)
              //       : CircularProgressIndicator(),
              // ),
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
      controller.image = await file.readAsBytes();
      controller.update();

      // return await file.readAsBytes();
    }
    print('No image se');
  }

  Future<String> selectImage() async {
    // Uint8List im = await pickImage();
    String _image = await controller.uploadImageToStorages(controller.image!);
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
