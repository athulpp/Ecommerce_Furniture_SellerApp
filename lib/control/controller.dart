import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController with SingleGetTickerProviderMixin {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    update(["indexchange"]);
  }

  late TabController? tabController;

  List<Tab> myTabs = <Tab>[
    Tab(
      child: Text('day'),
    ),
    Tab(
      child: Text('day'),
    ),
    Tab(
      child: Text('day'),
    )
  ];

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }

  // @override
  // void OnClose() {
  //   tabController.dispose();
  //   super.onClose();
  // }
}
