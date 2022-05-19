import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
          if (snapshot.data == null) {
            return Lottie.asset('assests/images/66208-furniture.json');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Lottie.asset('assests/images/66208-furniture.json');
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];

                return (snapshot.data == null)
                    ? Lottie.asset('assests/images/66208-furniture.json')
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              // Get.to(() => DetailScreen(
                              //       productId: documentSnapshot.id,
                              //       productName:
                              //           documentSnapshot['productname'],
                              //       productDesc:
                              //           documentSnapshot['productdes'],
                              //       productPrice:
                              //           documentSnapshot['productprice'],
                              //       productQuantity:
                              //           documentSnapshot['productquantity'],
                              //       productImage:
                              //           documentSnapshot['productimage'],
                              //     ));

                              title: Column(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    documentSnapshot['productname'],
                                    style: GoogleFonts.acme(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      // color: Colors.grey.shade100,
                                      // border: Border.all(color: Colors.grey),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            documentSnapshot['productimage']),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // subtitle: Text(
                              //   documentSnapshot['productname'],
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                              trailing: Wrap(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(15.0),
                                      // padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          color: Colors.white),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(20),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green),
                                        ),
                                        onPressed: () {
                                          Get.defaultDialog(
                                              buttonColor: Colors.white,
                                              barrierDismissible: true,
                                              title: 'Edit Product',
                                              titleStyle:
                                                  TextStyle(fontSize: 18),
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
                                                      productName:
                                                          documentSnapshot[
                                                              'productname'],
                                                      productDesc:
                                                          documentSnapshot[
                                                              'productdes'],
                                                      productPrice:
                                                          documentSnapshot[
                                                              'productprice'],
                                                      productQuantity:
                                                          documentSnapshot[
                                                              'productquantity'],
                                                      // productCategory:
                                                      //     documentSnapshot[
                                                      //         'productCategory'],
                                                      productImage:
                                                          documentSnapshot[
                                                              'productimage'],
                                                    ));
                                              });
                                        },
                                        child: Text(
                                          'Update',
                                          style: GoogleFonts.adamina(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.all(15.0),
                                      // padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          color: Colors.white),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          // elevation: MaterialStateProperty.all(20),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                          // padding: MaterialStateProperty.all(
                                          //     const EdgeInsets.symmetric(
                                          //         horizontal: 10, vertical: 10)),
                                        ),
                                        onPressed: () {
                                          Get.defaultDialog(
                                              buttonColor: Colors.white,
                                              barrierDismissible: true,
                                              title: 'Delete Product',
                                              titleStyle:
                                                  TextStyle(fontSize: 18),
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
                                                    productId:
                                                        documentSnapshot.id,
                                                    productName:
                                                        documentSnapshot[
                                                            'productname'],
                                                    productDes:
                                                        documentSnapshot[
                                                            'productdes'],
                                                    productPrice:
                                                        documentSnapshot[
                                                            'productprice'],
                                                    productQuantity:
                                                        documentSnapshot[
                                                            'productquantity'],
                                                    // productCategory:
                                                    //     documentSnapshot[
                                                    //         'productcategory'],
                                                    file: documentSnapshot[
                                                        'productimage']);
                                                Get.to(
                                                    () => BottomNavigation());
                                              }

                                              // confirm: data_control.logOut(context),
                                              );
                                        },
                                        child: Text(
                                          'Delete',
                                          style: GoogleFonts.adamina(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
              }));
        });
  }
}
