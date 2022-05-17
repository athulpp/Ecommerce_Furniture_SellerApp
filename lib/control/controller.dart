import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  // static String productid = '';
  // static String productId = '';
  // static String productname = '';
  // static String productprice = '';
  // static String productQuantity = '';
  // static String productRating = '';
  // static String productImage = '';

  // static Future<String> AddProduct(ProductModel model) async {
  //   final firestore = FirebaseFirestore.instance.collection(productId).doc();
  //   model.productId = firestore.id;
  //   await firestore.set(
  //     model.toJson(),
  //   );
  //   return firestore.id;
  // }
//   Future<String> loginUser({required String email, required String password}) {
//     String res = 'Some Error';

//     try{
// if (email.isNotEmpty|| password.isNotEmpty){

// }
//     }catch{

//     }
//   }

  // Stream<List<Product>> getproduct() =>
  //     FirebaseFirestore.instance.collection(products).snapshots().map(
  //           (snapshot) => snapshot.docs
  //               .map(
  //                 (json) => Product.fromJson(
  //                   json.data(),
  //                 ),
  //               )
  //               .toList(),
  //         );

  final storage = new FlutterSecureStorage();
  logOut(context) async {
    await FirebaseAuth.instance.signOut();
    await storage.delete(key: "uid");

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
  final auth = FirebaseAuth.instance;

  Future<String> Addproduct(
      {required String productId,
      required String productName,
      required String productDes,
      required String productQuantity,
      required String productPrice,
      // required String productCategory,
      required String file}) async {
    final fireStore = FirebaseFirestore.instance;
    // .collection(
    //   'products',
    // )
    // .doc();

    try {
      if (productName.isNotEmpty ||
          productDes.isNotEmpty ||
          productQuantity.isNotEmpty ||
          productPrice.isNotEmpty ||
          file.isNotEmpty) ;

      // String PhotoUrl = await uploadImageToStorage('productPic', file);
      // var uuid = Uuid().v1();
      Product product = Product(
          id: productId,
          productName: productName,
          ProductDescripition: productDes,
          prdouctPrice: productPrice,
          productQuantity: productQuantity,
          // productCategory: productCategory,
          productImage: file);

      fireStore.collection('products').doc(productId).set(product.toJson());
      var result = 'Success';
    } catch (e) {
      String result = e.toString();
    }
    // final json = product.toJson();
    // await fireStore.set(json);
    // return fireStore.id;
    return productName;
  }

  Future deleteProduct(
      {required String productId,
      required String productName,
      required String productDes,
      required String productQuantity,
      // required String productCategory,
      required String productPrice,
      required String file}) async {
    Product product = Product(
        id: productId,
        productName: productName,
        ProductDescripition: productDes,
        prdouctPrice: productPrice,
        productQuantity: productQuantity,
        // productCategory: productCategory,
        productImage: file);
    final fireStore = FirebaseFirestore.instance;
    fireStore.collection('products').doc(productId).delete();
  }

  Future updateProduct(
      {required String productId,
      required String productName,
      required String productDes,
      required String productQuantity,
      // required String productCategory,
      required String productPrice,
      required String file}) async {
    Product product = Product(
        id: productId,
        productName: productName,
        ProductDescripition: productDes,
        prdouctPrice: productPrice,
        productQuantity: productQuantity,
        // productCategory:productCategory ,
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
      print("""888
reached
 to
  upload
  
  
          """);
      Reference ref = _storage.ref("productsimages/$id");
      print("888  ${ref.toString()}");
      UploadTask uploadTask = ref.putData(file);
      final ss = await uploadTask;
      final link = await ss.ref.getDownloadURL();
      return link;
    } on FirebaseException catch (e) {

      print("888 ${e.toString()}");
    }
    // final snapshot =  await uploadTask;
    // return await snapshot.ref.getDownloadURL();
    return "error";
  }
}

// class Uint8List {
// 
