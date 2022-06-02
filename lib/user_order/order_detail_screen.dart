import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller/control/bottom_navigation.dart';
import 'package:seller/model/address.dart';
import 'package:seller/model/cart.dart';
import 'package:seller/model/order.dart';

class MyOrderDetailsScreen extends StatelessWidget {
  MyOrderDetailsScreen(
      {Key? key,
      required this.username,
      required this.userId,
      required this.address,
      required this.phonNo,
      required this.pin,
      required this.orderName,
      required this.orderDes,
      required this.prodPrice,
      required this.orderId,
      required this.orderImage,
      required this.orderPrice,
      required this.Quantity,
      required this.OrderDate,
      required this.status})
      : super(key: key);
  String username;
  String userId;
  String address;
  String phonNo;
  String pin;
  String orderName;
  String orderDes;
  String prodPrice;
  final orderId;
  final orderImage;
  double orderPrice;
  String Quantity;
  Timestamp OrderDate;
  String status;

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Order Summary',
              style: GoogleFonts.raleway(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
          ),
          body: Container(
            color: Colors.white,
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Container(
                    height: size.height / 5,
                    width: size.width / 1.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(orderImage.toString()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Text(
                    orderName,
                    style: GoogleFonts.acme(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    borderOnForeground: true,
                    color: Colors.grey.shade300,
                    shadowColor: Colors.brown,
                    type: MaterialType.button,
                    elevation: 5,
                    // color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      width: size.width / 1.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Details",
                            style: GoogleFonts.acme(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: size.height / 40,
                          ),
                          Text(
                            'Order Id : $orderId'.toString().substring(
                                  0,
                                  30,
                                ),
                            style: GoogleFonts.acme(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Total Price : ₹ $orderPrice',
                              style: GoogleFonts.acme(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                    
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Status : $status',
                              style: GoogleFonts.acme(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            'Ordered on : ${DateTime.fromMicrosecondsSinceEpoch(OrderDate.microsecondsSinceEpoch).toString().substring(0, 10)}',
                            style: GoogleFonts.acme(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                
                        ],
                      ),
                    ),
                  ),
               const   SizedBox(
                    height: 20,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    borderOnForeground: true,
                    color: Colors.grey.shade300,
                    shadowColor: Colors.brown,
                    type: MaterialType.button,
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      width: size.width / 1.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address Details",
                            style: GoogleFonts.acme(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: size.height / 40,
                          ),
                          Text(
                            'Name: $username',
                            style: GoogleFonts.acme(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Address : $address',
                              style: GoogleFonts.acme(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
     
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Phone No : $phonNo',
                              style: GoogleFonts.acme(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            'Pincode : $pin',
                            style: GoogleFonts.acme(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: size.height / 14,
            width: size.width,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    size,
                    () {
                      (status == 'Rejected')
                          ? Fluttertoast.showToast(
                              msg: 'The Order is already Rejected',
                              fontSize: 24)
                          : changeStatus(Order(
                              orderId: orderId,
                              userId: userId,
                              createdDate: OrderDate,
                              cart: Cart(
                                  productName: orderName,
                                  productDes: orderDes,
                                  productPrice: orderPrice.toString(),
                                  ProductQuantity: Quantity,
                                  productImage: orderImage),
                              address: Address(
                                  name: username,
                                  address: address,
                                  pincode: pin,
                                  PhoneNumber: phonNo),
                              status: 'Delivery in 7 day',
                              totalPrice: orderPrice));
                      Get.off(() => BottomNavigation(
                            currentIndex: 2,
                          ));
                    },
                    Colors.green,
                    "Deliver",
                  ),
                ),
                Expanded(
                  child: CustomButton(size, () {
                    (status == 'Delivery in 7 day')
                        ? Fluttertoast.showToast(msg: 'Order is Placed')
                        : cancelStatus(Order(
                            orderId: orderId,
                            userId: userId,
                            createdDate: OrderDate,
                            cart: Cart(
                                productName: orderName,
                                productDes: orderDes,
                                productPrice: orderPrice.toString(),
                                ProductQuantity: Quantity,
                                productImage: orderImage),
                            address: Address(
                                name: username,
                                address: address,
                                pincode: pin,
                                PhoneNumber: phonNo),
                            status: 'Rejected',
                            totalPrice: orderPrice));
                    Get.off(() => BottomNavigation(
                          currentIndex: 2,
                        ));
                  }, Colors.white, "Reject Order"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomButton(
      Size size, VoidCallback function, Color color, String title) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: Text(
          title,
          style: GoogleFonts.rakkas(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

Widget orderDetails(Size size, each) {
  Widget text(String header, String footer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          footer,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  return Material(
    elevation: 5,
    color: Colors.white,
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      width: size.width / 1.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Details",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height / 40,
          ),
          text('Order Id :', each),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: text('Total Price :', 'model.totalPrice.toString()'),
          ),
          text('Paid amount :', 'model.totalPrice.toString()'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child:
                text('Status :', 'model.status == 0 ?' 'Pending' ': Delivered'),
          ),
          text('Ordered on :', '11-12-2021'),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 12),
          //   child: text('Delivered on :', '28-10-2021'),
          // ),
        ],
      ),
    ),
  );
}

void changeStatus(
  Order model,
) async {
  final orderCollection = FirebaseFirestore.instance
      .collection('OrderCollection')
      .doc(model.userId)
      .collection('order')
      .doc(model.orderId)
      .update(model.toMap());
  // model.status = currentStatus;
  // orderCollection.set(model.toMap()).then((value) {

  // });
  // getOrders();
}

void cancelStatus(Order model) async {
  final orderCollection = FirebaseFirestore.instance
      .collection('OrderCollection')
      .doc(model.userId)
      .collection('order')
      .doc(model.orderId)
      .update(model.toMap());
}
//   Future<String>getTokenId(String id) async {
//   final token =
//       await FirebaseFirestore.instance.collection('users').doc(id).get();
//   return token.data()!['token'];
// }