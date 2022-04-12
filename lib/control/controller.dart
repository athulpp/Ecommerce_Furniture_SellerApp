import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller/control/bottom_navigation.dart';
import 'package:seller/home/product_model.dart';
import 'package:seller/login/login_screen.dart';

class Controller extends GetxController {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    update(["indexchange"]);
  }

  // static String productid = '';
  static String productId = '';
  // static String productname = '';
  // static String productprice = '';
  // static String productQuantity = '';
  // static String productRating = '';
  // static String productImage = '';

  static Future<String> AddProduct(ProductModel model) async {
    final firestore = FirebaseFirestore.instance.collection(productId).doc();
    model.productId = firestore.id;
    await firestore.set(
      model.toJson(),
    );
    return firestore.id;
  }
//   Future<String> loginUser({required String email, required String password}) {
//     String res = 'Some Error';

//     try{
// if (email.isNotEmpty|| password.isNotEmpty){

// }
//     }catch{

//     }
//   }
  final storage = new FlutterSecureStorage();
  void logOut(context) async {
    await FirebaseAuth.instance.signOut();
    await storage.delete(key: "uid");
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginScreen()),
    //     (route) => false);
    Get.to(() => LoginScreen());


  }

//   final auth = FirebaseAuth.instance;
// String userEmail = 'userId';
// // Uint8List? file;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // Future<String> createProduct(ProductModel model) async {
// //   final fireStore = FirebaseFirestore.instance
// //       .collection(
// //         userEmail,
// //       )
// //       .doc();
final auth =FirebaseAuth.instance;


}
