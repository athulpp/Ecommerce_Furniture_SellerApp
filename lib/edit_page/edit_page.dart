import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller/add_product/new_product.dart';
import 'package:seller/control/bottom_navigation.dart';
import 'package:seller/control/controller.dart';

class EditProduct extends StatelessWidget {
  EditProduct(
      {Key? key,
      required this.productName,
      required this.productId,
      required this.productDesc,
      required this.productPrice,
      required this.productQuantity,
      // required this.productCategory,
      required this.productImage})
      : super(key: key);
  final productId;
  String productName;
  String productDesc;
  String productPrice;
  String productQuantity;
  // String productCategory;
  String productImage;
  TextEditingController _productName = TextEditingController();
  TextEditingController _productDescripiton = TextEditingController();
  TextEditingController _prodcutQuantity = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  // TextEditingController _productCategory = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Uint8List? imag;
  // var name;
  // var desc;
  // var price;
  // var quantity;

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
      print(productName);
      // print("$productDesc product des");
      initEditButton();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Edit Product',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                            // if (imag!.isEmpty) {
                            //   return;
                            // }
                            await pickImage();
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
                        ),
                        GetBuilder<Controller>(
                            // id: 'product',
                            builder: (controller) {
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
                const Text(
                  'Update Product Informations',
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
                          controller: _productDescripiton,
                          onSaved: (value) {
                            _productDescripiton.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Product Descipition required';
                            }
                          },
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
                          decoration:
                              InputDecoration(hintText: 'Product Price'),
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
                        //  TextFormField(
                        //   onSaved: (value) {
                        //     _productCategory.text = value!;
                        //   },
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Product Quantity is Required';
                        //     }
                        //   },
                        //   controller: _productCategory,
                        //   decoration:
                        //       InputDecoration(hintText: 'Product Quantity'),
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
                    child: const Text(
                      'update',
                      style: TextStyle(
                        fontSize: 14,
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
      controller.upimage = await file.readAsBytes();
      controller.update();
    }
    print('No image se');
  }

  Future<String> selectImage() async {
    // Uint8List im = await pickImage();
    String _image =
        await controller.updateImageToStorage('prod', controller.upimage!);
    return _image;
  }
}
