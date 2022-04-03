import 'package:flutter/material.dart';

import '../const/constant.dart';
import '../const/custom_button.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text('ENTER THE PRODUCT NAME'),
              height10,
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20),
              TextFormField(
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'price'),
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
}
