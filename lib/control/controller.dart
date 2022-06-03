import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:seller/add_product/new_product.dart';
import 'package:seller/login/login_screen.dart';
import 'package:seller/model/product_model.dart';
import 'package:uuid/uuid.dart';

Controller controller = Get.find();

class Controller extends GetxController {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    update(["indexchange"]);
  }

  Uint8List? image;

  Uint8List? upimage;

  static String products = 'a';

  final storage = const FlutterSecureStorage();
  logOut(context) async {
    await FirebaseAuth.instance.signOut();
    await storage.delete(key: "uid");

    Get.to(() => LoginScreen());
  }

  final auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  Future<String> Addproduct(
      {required String productId,
      required String productName,
      required String productDes,
      required String productQuantity,
      required String productPrice,
      required String file}) async {
    final fireStore = FirebaseFirestore.instance;

    try {
      if (productName.isNotEmpty ||
          productDes.isNotEmpty ||
          productQuantity.isNotEmpty ||
          productPrice.isNotEmpty ||
          file.isNotEmpty) ;

      Product product = Product(
          id: productId,
          productName: productName,
          ProductDescripition: productDes,
          prdouctPrice: productPrice,
          productQuantity: productQuantity,
          productImage: file);

      fireStore.collection('products').doc(productId).set(product.toJson());
      var result = 'Success';
    } catch (e) {
      debugPrint(e.toString());
    }

    return productName;
  }

  Future deleteProduct(
      {required String productId,
      required String productName,
      required String productDes,
      required String productQuantity,
      required String productPrice,
      required String file}) async {
    Product product = Product(
        id: productId,
        productName: productName,
        ProductDescripition: productDes,
        prdouctPrice: productPrice,
        productQuantity: productQuantity,
        productImage: file);
    final fireStore = FirebaseFirestore.instance;
    fireStore.collection('products').doc(productId).delete();
  }

  Future updateProduct(
      {required String productId,
      required String productName,
      required String productDes,
      required String productQuantity,
      required String productPrice,
      required String file}) async {
    Product product = Product(
        id: productId,
        productName: productName,
        ProductDescripition: productDes,
        prdouctPrice: productPrice,
        productQuantity: productQuantity,
        productImage: file);
    final fireStore = FirebaseFirestore.instance;
    fireStore.collection('products').doc(productId).update(product.toJson());
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final photoid = uuid.v1();

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName).child(photoid);

    UploadTask uploadTask = ref.putData(file);
    await uploadTask;

    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> updateImageToStorage(String childName, Uint8List file) async {
    Reference reference = _storage.ref().child(childName).child(photoid);
    reference.delete();
    Reference reference1 = _storage.ref().child(childName).child(photoid);
    UploadTask uploadTask = reference1.putData(file);

    await uploadTask;

    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> uploadImageToStorages(Uint8List file) async {
    String id = const Uuid().v1();
    try {
      Reference ref = _storage.ref("productsimages/$id");

      UploadTask uploadTask = ref.putData(file);
      final ss = await uploadTask;
      final link = await ss.ref.getDownloadURL();
      return link;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }

    return "error";
  }
}
