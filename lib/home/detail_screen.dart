import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
  // ignore: prefer_typing_uninitialized_variables
  final productId;
  String productName;
  String productDesc;
  String productPrice;
  String productQuantity;
  String productImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade200,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        title: const Text(
          'Product Detail ',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
  
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.brown.shade200,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Image.network(productImage),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.445,
            decoration:  BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius:const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    productName,
                    overflow: TextOverflow.ellipsis,
                    style:const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    productDesc,
                    style: const TextStyle(fontSize: 16),
                  ),
                const  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.brown.shade100,
                        borderRadius:const BorderRadius.all(Radius.circular(20))),
                    width: 300,
                    height: 100,
                    child: Row(
                      children: [
                       const SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Price: ₹$productPrice",
                          style:const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      const  SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Quantity: $productQuantity",
                          style:const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 
}
