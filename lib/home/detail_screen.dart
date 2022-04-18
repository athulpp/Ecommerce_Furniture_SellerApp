import 'package:flutter/material.dart';
import 'package:seller/model/product_model.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen(
      {Key? key,
      required this.productId,
      required this.productName,
      required this.productDesc,
      required this.productQuantity,
      required this.productPrice,
      required this.productImage})
      : super(key: key);
  final productId;
  String productName;
  String productDesc;
  String productPrice;
  String productQuantity;
  String productImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        title: Text(
          'Product Detail ',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.brown.shade200,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Image.network(productImage),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                    
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        productDesc,
                        style: const TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "productPrice: ₹$productPrice",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "productQuantity: $productQuantity",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void product() {
    print(productPrice);
  }
}
