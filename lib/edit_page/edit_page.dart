import 'dart:typed_data';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:seller/control/bottom_navigation.dart';
import 'package:seller/control/controller.dart';

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  EditProduct(
      {Key? key,
      required this.productName,
      required this.productId,
      required this.productDesc,
      required this.productPrice,
      required this.productQuantity,
      required this.productImage})
      : super(key: key);
  final productId;
  String productName;
  String productDesc;
  String productPrice;
  String productQuantity;

  String productImage;
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productDescripiton = TextEditingController();
  final TextEditingController _prodcutQuantity = TextEditingController();
  final TextEditingController _productprice = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // final FirebaseStorage _storage = FirebaseStorage.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  Uint8List? imag;

  initEditButton() async {
    _productName.text = productName;
    _productDescripiton.text = productDesc;
    _productprice.text = productPrice;
    _prodcutQuantity.text = productQuantity;
    // _productCategory.text = productCategory;
  }

  @override
  Widget build(BuildContext context) {
    if (productName != null) {
      initEditButton();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Edit Product',
          style: GoogleFonts.actor(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                            await pickImage();
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Add Image',
                          style: GoogleFonts.actor(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        GetBuilder<Controller>(builder: (controller) {
                          return Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                image: controller.upimage != null
                                    ? DecorationImage(
                                        image: MemoryImage(controller.upimage!))
                                    : DecorationImage(
                                        image: NetworkImage(productImage))),
                          );
                        })
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Update Product Informations',
                  style: GoogleFonts.actor(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: GoogleFonts.actor(fontSize: 20),
                          controller: _productName,
                          onSaved: (value) {
                            _productName.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Product Name";
                            }
                          },
                          decoration:const InputDecoration(hintText: 'Product Name'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: GoogleFonts.actor(fontSize: 20),
                          controller: _productDescripiton,
                          onSaved: (value) {
                            _productDescripiton.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Product Descipition required';
                            }
                          },
                          decoration: const InputDecoration(
                              hintText: 'Product Descripition'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: GoogleFonts.abel(fontSize: 20),
                          onSaved: (value) {
                            _productprice.text = value!;
                          },
                          controller: _productprice,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'product Price is Required';
                            }
                          },
                          decoration:
                              const InputDecoration(hintText: 'Product Price'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: GoogleFonts.abel(fontSize: 20),
                          onSaved: (value) {
                            _prodcutQuantity.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Product Quantity is Required';
                            }
                          },
                          controller: _prodcutQuantity,
                          decoration: const InputDecoration(
                              hintText: 'Product Quantity'),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic imgUrl = await selectImage();

                        controller.updateProduct(
                            productId: productId,
                            productName: _productName.text,
                            productDes: _productDescripiton.text,
                            productQuantity: _prodcutQuantity.text,
                            // productCategory: _productCategory.text,
                            productPrice: _productprice.text,
                            file: imgUrl);
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => BottomNavigation()))
                            .whenComplete;
                        Fluttertoast.showToast(
                            msg: "Products Details Updated!!!");
                      }
                    },
                    child: Text(
                      'update',
                      style: GoogleFonts.abel(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assests/images/icons8-update-64.png',
                    width: 300,
                    height: 300,
                    scale: 1,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImage() async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      controller.upimage = await file.readAsBytes();
      controller.update();
    }
  }

  Future<String> selectImage() async {
    String _image =
        await controller.updateImageToStorage('prod', controller.upimage!);
    return _image;
  }
}
