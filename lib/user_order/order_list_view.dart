import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:seller/model/order.dart';
import 'package:seller/user_order/order_detail_screen.dart';

class OrderListView extends StatelessWidget {
  OrderListView({Key? key}) : super(key: key);
  final _orderStream = FirebaseFirestore.instance
      .collection('OrderCollection')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('order')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: StreamBuilder<QuerySnapshot>(
          stream: _orderStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {}
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Lottie.asset('assests/images/66208-furniture.json');
            }
            List<Order> orderList = [];
            for (var item in snapshot.data!.docs) {
              orderList.add(Order.fromMap(item));
            }
            return ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  final each = orderList[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Column(
                      children: [
                        // GestureDetector(
                        // onTap: () {
                        // TextButton(
                        //     onPressed: () {
                        //       Get.to(() => MyOrderDetailsScreen(
                        //             username: each.address.name.toString(),
                        //             userId: each.userId.toString(),
                        //             address: each.address.address.toString(),
                        //             phonNo: each.address.PhoneNumber.toString(),
                        //             pin: each.address.pincode.toString(),
                        //             orderName: each.cart.productName,
                        //             orderDes: each.cart.productDes,
                        //             prodPrice: each.cart.productPrice,
                        //             orderId: each.orderId,
                        //             orderImage: each.cart.productImage,
                        //             orderPrice: each.totalPrice,
                        //             Quantity: each.cart.ProductQuantity,
                        //             OrderDate: each.createdDate,
                        //             status: each.status,
                        //           ));
                        //     },
                        //     child: Text('View More')),

                        // },
                        // child: Card(
                        //   shadowColor: Colors.black,
                        //   clipBehavior: Clip.antiAlias,
                        //   elevation: 5,
                        //   color: Colors.grey.shade300,
                        //   child: ListTile(
                        //     leading: Text(
                        //       each.address.name.toString(),
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold, fontSize: 24),
                        //     ),
                        //     title: Text(
                        //       each.cart.productName,
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold, fontSize: 16),
                        //     ),
                        //     subtitle: Text(
                        //       'Quantiity: ${each.cart.ProductQuantity}',
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold, fontSize: 16),
                        //     ),
                        //     trailing: Text(
                        //       'Date: ${DateTime.fromMicrosecondsSinceEpoch(each.createdDate.microsecondsSinceEpoch).toString().substring(0, 10)}',
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold, fontSize: 16),
                        //     ),
                        //   ),
                        // ),
                        // child: Table(
                        //   textDirection: TextDirection.ltr,
                        //   defaultVerticalAlignment:
                        //       TableCellVerticalAlignment.middle,
                        //   border:
                        //       TableBorder.all(width: 2.0, color: Colors.red),
                        //   // border: TableBorder.all(
                        //   //     color: Colors.black,
                        //   //     style: BorderStyle.solid,
                        //   //     width: 2),
                        //   children: [
                        //     TableRow(children: [
                        //       Column(
                        //         children: [
                        //           Center(
                        //               child: Text(
                        //             '${index + 1}',
                        //             textAlign: TextAlign.center,
                        //           ))
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text(
                        //             each.address.name.toString(),
                        //             style: TextStyle(fontSize: 20),
                        //           ),
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text(
                        //             each.cart.productName,
                        //             style: TextStyle(fontSize: 20),
                        //           ),
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text(
                        //             each.cart.ProductQuantity,
                        //             style: TextStyle(fontSize: 20),
                        //           )
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text(
                        //             DateTime.fromMicrosecondsSinceEpoch(each
                        //                     .createdDate
                        //                     .microsecondsSinceEpoch)
                        //                 .toString()
                        //                 .substring(0, 10),
                        //             style: TextStyle(fontSize: 18),
                        //           )
                        //         ],
                        //       )
                        //     ]),
                        //   ],
                        // ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.green,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.green),
                                    child: Center(
                                      child: Text(
                                        'Sl No: ${index + 1}',
                                        style: GoogleFonts.abel(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    each.cart.productName,
                                    textScaleFactor: 1.5,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                (each.status == 'Rejected' ||
                                        each.status == 'cancelled')
                                    ? Text(
                                        each.status,
                                        style: GoogleFonts.abel(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )
                                    : Text(
                                        each.status,
                                        style: GoogleFonts.abel(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => MyOrderDetailsScreen(
                                          username:
                                              each.address.name.toString(),
                                          userId: each.userId.toString(),
                                          address:
                                              each.address.address.toString(),
                                          phonNo: each.address.PhoneNumber
                                              .toString(),
                                          pin: each.address.pincode.toString(),
                                          orderName: each.cart.productName,
                                          orderDes: each.cart.productDes,
                                          prodPrice: each.cart.productPrice,
                                          orderId: each.orderId,
                                          orderImage: each.cart.productImage,
                                          orderPrice: each.totalPrice,
                                          Quantity: each.cart.ProductQuantity,
                                          OrderDate: each.createdDate,
                                          status: each.status,
                                        ));
                                  },
                                  child: Text('View More',
                                      style: GoogleFonts.adventPro(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20)),
                                      textStyle:
                                          MaterialStateProperty.all(TextStyle(
                                        color: Colors.black,
                                      )),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Table(
                                columnWidths: {
                                  0: FractionColumnWidth(.4),
                                  1: FractionColumnWidth(.2),
                                  2: FractionColumnWidth(.4)
                                },
                                textDirection: TextDirection.rtl,
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.bottom,
                                border: TableBorder.all(
                                    width: 1.0,
                                    color: Color.fromARGB(255, 102, 102, 102)),
                                children: [
                                  TableRow(
                                      // decoration: tablede,
                                      children: [
                                        Center(
                                          child: Text("Product.",
                                              textScaleFactor: 1.5,
                                              style: GoogleFonts.abel(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Center(
                                          child: Text("Quantity",
                                              textScaleFactor: 1.35,
                                              style: GoogleFonts.abel(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Center(
                                          child: Text("Date",
                                              textScaleFactor: 1.5,
                                              style: GoogleFonts.abel(
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ]),
                                  TableRow(children: [
                                    Text(each.cart.productName,
                                        textScaleFactor: 1.2),
                                    Text(each.cart.ProductQuantity,
                                        textScaleFactor: 1.5),
                                    Text(
                                        DateTime.fromMicrosecondsSinceEpoch(each
                                                .createdDate
                                                .microsecondsSinceEpoch)
                                            .toString()
                                            .substring(0, 10),
                                        textScaleFactor: 1.2),
                                  ]),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 5,
                            )
                          ],
                        ),
                        // ),
                      ],
                    ),
                  );
                });
          }),
    );
    // ListView.builder(
    //   itemCount: 10,
    //   itemBuilder: (context, index) {
    //     return Padding(
    //       padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
    //       child: Card(
    //         shadowColor: Colors.black,
    //         clipBehavior: Clip.antiAlias,
    //         elevation: 5,
    //         color: Colors.grey.shade300,
    //         child: ListTile(
    //           leading: Text('User Name'),
    //           title: Text('product Name'),
    //           subtitle: Text('item count'),
    //           trailing: Text('Date purcahsed'),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
