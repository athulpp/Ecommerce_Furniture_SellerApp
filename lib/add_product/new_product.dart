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

import 'package:uuid/uuid.dart';

var uuid =const Uuid();

// ignore: must_be_immutable
class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);
 final TextEditingController _productName = TextEditingController();
 final TextEditingController _productDescripiton = TextEditingController();
  final TextEditingController _prodcutQuantity = TextEditingController();
  final TextEditingController _productprice = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // final FirebaseStorage _storage = FirebaseStorage.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
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
                            const SizedBox(
                              width: 90,
                            ),
                            GetBuilder<Controller>(builder: (controller) {
                              return Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  image: controller.image == null
                                      ? const DecorationImage(
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
              const SizedBox(
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
                          RegExp regex = RegExp(r'^.{4,}$');
                          if (value!.isEmpty) {
                            return "Please Enter Product Name";
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Minum 4 lettters required");
                          }
                        },
                        decoration:
                            const InputDecoration(hintText: 'Product Name'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: GoogleFonts.habibi(fontSize: 18),
                        onSaved: (value) {
                          _productDescripiton.text = value!;
                        },
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{20,}$');
                          if (value!.isEmpty) {
                            return 'Product Descipition required';
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Minum 20 lettters required");
                          }
                        },
                        controller: _productDescripiton,
                        decoration: const InputDecoration(
                            hintText: 'Product Descripition'),
                      ),
                      const SizedBox(
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
                        decoration:
                            const InputDecoration(hintText: 'Product Price'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: GoogleFonts.habibi(fontSize: 18),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _prodcutQuantity.text = value!;
                        },
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{1,}$');
                          if (value!.isEmpty) {
                            return 'Product Quantity is Required';
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Minimum 1 product required)");
                          }
                          return null;
                        },
                        controller: _prodcutQuantity,
                        decoration:
                           const InputDecoration(hintText: 'Product Quantiy'),
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

                      await controller.Addproduct(
                          productId: uuid.v4(),
                          productName: _productName.text,
                          productDes: _productDescripiton.text,
                          productQuantity: _prodcutQuantity.text,
                          productPrice: _productprice.text,
                          file: imgUrl);

                      controller.image == null;

                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => BottomNavigation(
                                    currentIndex: 0,
                                  )))
                          .whenComplete;

                      Fluttertoast.showToast(msg: "Product Added Sucessfully!");
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
            ],
          ),
        ),
      ),
    );
  }

  pickImage() async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      controller.image = await file.readAsBytes();
      controller.update();
    }
  }

  Future<String> selectImage() async {
    String _image = await controller.uploadImageToStorages(controller.image!);
    return _image;
  }
}
