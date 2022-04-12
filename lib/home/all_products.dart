import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller/home/product_detail.dart';

class AllProductList extends StatelessWidget {
  const AllProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView.builder(itemBuilder: ((context, index) {
      return getCard();
    }));
  }

  Widget getCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
              onTap: () {
                Get.to(() => const ProductDetailScreen());
              },
              title: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://m.media-amazon.com/images/I/71+xw4gRDDL._SX569_.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                'product name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Wrap(
                children: [
                  Container(
                      margin: const EdgeInsets.all(15.0),
                      // padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.white),
                      child: TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(20),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          // padding: MaterialStateProperty.all(
                          //     const EdgeInsets.symmetric(
                          //         horizontal: 10, vertical: 10)),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.all(15.0),
                      // padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.white),
                      child: TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(20),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          // padding: MaterialStateProperty.all(
                          //     const EdgeInsets.symmetric(
                          //         horizontal: 10, vertical: 10)),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
