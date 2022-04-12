

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../const/constant.dart';
import '../const/custom_button.dart';

class AddNewProduct extends StatelessWidget {
  AddNewProduct({Key? key}) : super(key: key);
  TextEditingController _productName = TextEditingController();
  TextEditingController _productDescripiton = TextEditingController();
  TextEditingController _prodcutQuantity = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //  final fileName = file != null ? basename(file!.path) : 'No File Selected';

    // my old design.........
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add New Product',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ENTER THE PRODUCT NAME'),
                    height10,
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, right: 20),
                    TextFormField(
                      onSaved: ((newValue) {
                        _productName.text = newValue!;
                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('Please enter the product Name');
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Product name'),
                    ),
                    height10,
                    Text('ENTER THE PRODUCT DESCRIPITION'),
                    height10,
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, right: 20),
                    TextFormField(
                      onSaved: ((newValue) {
                        _productDescripiton.text = newValue!;
                      }),
                      validator: (value) {
                        if (_productDescripiton.text.isEmpty) {
                          return ('Please enter the Product Descripition');
                        }
                      },
                      minLines: 1,
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'decription'),
                    ),
                    height10,
                    Text('ENTER THE NO OF PRODUCTS'),
                    height10,
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, right: 20),
                    TextFormField(
                      onSaved: ((newValue) {
                        _prodcutQuantity.text = newValue!;
                      }),
                      validator: ((value) {
                        RegExp regex = new RegExp(r'^.{1,}$');
                        if (_prodcutQuantity.text.isEmpty) {
                          return 'Please Add product';
                        }
                        if (!regex.hasMatch(value!)) {
                          return ("Enter Valid Quantity(Min. 1 Product)");
                        }
                      }),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'quantity'),
                    ),
                    height10,
                    Text('ENTER THE PRODUCT PRICE'),
                    height10,
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, right: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (_productprice.text.isEmpty) {
                          return ('Please Enter the Product Price');
                        }
                      },
                      onSaved: (value) {
                        _productprice.text = value!;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'price'),
                    ),
                  ],
                ),
              ),

              height10,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ADD PRODUCT IMAGE'),
                    Container(
                      width: 100,
                      child: MaterialButton(
                        color: Colors.black,
                        onPressed: () {},
                        child: Text(
                          'Photo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                onPressed: () {},
                text: 'Add product',
              )

              // ),
            ],
          ),
        ),
      ),
    );
  }
  // addProduct()async{
  //   if(_productName.text.isEmpty&& _productDescripiton.text.isEmpty&& _prodcutQuantity.text.isEmpty && )

  // }

  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  //   if (result == null) {
  //     return;
  //   }
  //   final path = result.files.single.path;
  // }

  // Future uploadFile() async {
  //   if (file == null) {
  //     return;
  //   }
  //   final fileName=basename(file!.path)
  //   final destination = 'files/$fileName';
  // }
}
