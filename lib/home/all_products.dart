import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:seller/control/bottom_navigation.dart';
import 'package:seller/control/controller.dart';
import 'package:seller/edit_page/edit_page.dart';

class AllProductList extends StatelessWidget {
  AllProductList({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _productStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  // final TextEditingController _productName = TextEditingController();
  // final TextEditingController _productDescripiton = TextEditingController();
  // final TextEditingController _prodcutQuantity = TextEditingController();
  // final TextEditingController _productprice = TextEditingController();
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
                              title: Column(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    documentSnapshot['productname'],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.acme(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
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
                              trailing: Wrap(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(15.0),
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
                                                  const TextStyle(fontSize: 18),
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
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          color: Colors.white),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                        ),
                                        onPressed: () {
                                          Get.defaultDialog(
                                              buttonColor: Colors.white,
                                              barrierDismissible: true,
                                              title: 'Delete Product',
                                              titleStyle:
                                                  const TextStyle(fontSize: 18),
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
                                                    file: documentSnapshot[
                                                        'productimage']);
                                                Get.to(
                                                    () => BottomNavigation());
                                              });
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
