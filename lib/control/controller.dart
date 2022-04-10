import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController with SingleGetTickerProviderMixin {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    update(["indexchange"]);
  }

//   Future<String> loginUser({required String email, required String password}) {
//     String res = 'Some Error';

//     try{
// if (email.isNotEmpty|| password.isNotEmpty){
  
// }
//     }catch{

//     }
//   }
}
