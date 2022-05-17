import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: StreamBuilder<QuerySnapshot>(
          stream: _orderStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {}
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Loading'));
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
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => MyOrderDetailsScreen(
                              username: each.address.name.toString(),
                              userId: each.userId.toString(),
                              address: each.address.address.toString(),
                              phonNo: each.address.PhoneNumber.toString(),
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
                      child: Card(
                        shadowColor: Colors.black,
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        color: Colors.grey.shade300,
                        child: ListTile(
                          leading: Text(
                            each.address.name.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          title: Text(
                            each.cart.productName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(
                            'Quantiity: ${each.cart.ProductQuantity}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          trailing: Text(
                            'Date: ${DateTime.fromMicrosecondsSinceEpoch(each.createdDate.microsecondsSinceEpoch).toString().substring(0, 10)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  );
                  ;
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
