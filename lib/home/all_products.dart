import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller/control/bottom_navigation.dart';
import 'package:seller/control/controller.dart';
import 'package:seller/edit_page/edit_page.dart';
import 'package:seller/home/detail_screen.dart';
import 'package:seller/home/product_detail.dart';
import 'package:seller/model/product_model.dart';

class AllProductList extends StatelessWidget {
  AllProductList({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _productStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  TextEditingController _productName = TextEditingController();
  TextEditingController _productDescripiton = TextEditingController();
  TextEditingController _prodcutQuantity = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: getBody(),
    );
  }

  Widget getBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                          onTap: () {
                            Get.to(() => DetailScreen(
                                  productId: documentSnapshot.id,
                                  productName: documentSnapshot['productname'],
                                  productDesc: documentSnapshot['productdes'],
                                  productPrice:
                                      documentSnapshot['productprice'],
                                  productQuantity:
                                      documentSnapshot['productquantity'],
                                  productImage:
                                      documentSnapshot['productimage'],
                                ));
                          },
                          title: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        documentSnapshot['productimage']),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            documentSnapshot['productname'],
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
                                          MaterialStateProperty.all(
                                              Colors.green),
                                      // padding: MaterialStateProperty.all(
                                      //     const EdgeInsets.symmetric(
                                      //         horizontal: 10, vertical: 10)),
                                    ),
                                    onPressed: () {
                                      // showBottomSheet(
                                      //     context: context,
                                      //     builder: (BuildContext context) {
                                      //       return AlertDialog(
                                      //         title:
                                      //             Text('Edit Product Details'),
                                      //         content: Text(
                                      //             'changes product edities in this'),
                                      //         actions: [
                                      //           ElevatedButton(
                                      //               onPressed: () {
                                      //   Get.to(() => EditProduct(,
                                      //         productId:
                                      //             documentSnapshot
                                      //                 .id,
                                      //         productName:
                                      //             documentSnapshot[
                                      //                 'productname'],
                                      //         productDesc:
                                      //             documentSnapshot[
                                      //                 'productprice'],
                                      //         productPrice:
                                      //             documentSnapshot[
                                      //                 'productprice'],
                                      //         productQuantity:
                                      //             documentSnapshot[
                                      //                 'productquantity'],
                                      //         productImage:
                                      //             documentSnapshot[
                                      //                 'productimage'],
                                      //       ),
                                      //       );
                                      // },
                                      //               child: Text('Yes')),
                                      //           ElevatedButton(
                                      //               onPressed: () {
                                      //                 Navigator.of(context)
                                      //                     .pop();
                                      //               },
                                      //               child: Text('No'))
                                      //         ],
                                      //       );
                                      //     });
                                      Get.defaultDialog(
                                          buttonColor: Colors.white,
                                          barrierDismissible: true,
                                          title: 'Edit Product',
                                          titleStyle: TextStyle(fontSize: 18),
                                          middleText:
                                              "Do you Want to Edit this Product",
                                          middleTextStyle: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          radius: 20,
                                          textCancel: 'No',
                                          cancelTextColor: Colors.green,
                                          textConfirm: 'Yes',
                                          confirmTextColor: Colors.red,
                                          onConfirm: () {
                                            Navigator.pop(context);
                                            Get.to(() => EditProduct(
                                                  productId:
                                                      documentSnapshot.id,
                                                  productName: documentSnapshot[
                                                      'productname'],
                                                  productDesc: documentSnapshot[
                                                      'productdes'],
                                                  productPrice:
                                                      documentSnapshot[
                                                          'productprice'],
                                                  productQuantity:
                                                      documentSnapshot[
                                                          'productquantity'],
                                                  productImage:
                                                      documentSnapshot[
                                                          'productimage'],
                                                ));
                                          }

                                          // confirm: data_control.logOut(context),
                                          );
                                    },
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
                                      // elevation: MaterialStateProperty.all(20),
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                      // padding: MaterialStateProperty.all(
                                      //     const EdgeInsets.symmetric(
                                      //         horizontal: 10, vertical: 10)),
                                    ),
                                    onPressed: () {
                                      Get.defaultDialog(
                                          buttonColor: Colors.white,
                                          barrierDismissible: true,
                                          title: 'Delete Product',
                                          titleStyle: TextStyle(fontSize: 18),
                                          // backgroundColor: Colors.grey,
                                          middleText:
                                              "Do you Want to Delete this Product",
                                          middleTextStyle: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          radius: 10,
                                          textCancel: 'No',
                                          cancelTextColor: Colors.green,
                                          textConfirm: 'Yes',
                                          confirmTextColor: Colors.red,
                                          onConfirm: () {
                                            Navigator.pop(context);
                                            controller.deleteProduct(
                                                productId: documentSnapshot.id,
                                                productName: documentSnapshot[
                                                    'productname'],
                                                productDes: documentSnapshot[
                                                    'productdes'],
                                                productPrice: documentSnapshot[
                                                    'productprice'],
                                                productQuantity:
                                                    documentSnapshot[
                                                        'productquantity'],
                                                file: documentSnapshot[
                                                    'productimage']);
                                            Get.to(() => BottomNavigation());
                                          }

                                          // confirm: data_control.logOut(context),
                                          );
                                    },
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
              }));
        });
  }
}
