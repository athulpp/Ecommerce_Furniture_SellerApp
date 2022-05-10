import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller/add_product/new_product.dart';
import 'package:seller/home/all_products.dart';


import '../analytics/analytics_screen.dart';

import '../search/search_screen.dart';
import '../user_order/order_screen.dart';
import 'controller.dart';

final data_control = Get.put(Controller());

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);
  List<String> headings = [
    'Product List',
    'Add Product',
    'Report',
    'User Order Screen'
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOption = [
      AllProductList(),
      // SeachScreen(),
      // AddNewProduct(),
      NewProductScreen(),
      // AnalyticScreen(),
      OrderScreen()
      // OrdersScreen(),
      // UserProfileScreen()
    ];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(() => SeachScreen());
            },
            icon: Icon(Icons.search_outlined)),
        backgroundColor: Colors.black,
        title: GetBuilder<Controller>(
          id: 'indexchange',
          builder: (controller) {
            return Text(headings[data_control.selectedIndex]);
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                // data_control.logOut(context);
                Get.defaultDialog(
                    buttonColor: Colors.white,
                    barrierDismissible: true,
                    title: 'Logout',
                    titleStyle: TextStyle(fontSize: 18),
                    middleText: "Do you Want to Logout ?",
                    middleTextStyle: const TextStyle(
                      fontSize: 16,
                    ),
                    radius: 20,
                    textCancel: 'No',
                    cancelTextColor: Colors.green,
                    textConfirm: 'Yes',
                    confirmTextColor: Colors.red,
                    onConfirm: () {
                      data_control.logOut(context);
                    }

                    // confirm: data_control.logOut(context),
                    );
              },
              icon: Icon(Icons.login_sharp))
        ],
      ),
      body: GetBuilder<Controller>(
          init: Controller(),
          id: 'indexchange',
          builder: (controller) {
            return _widgetOption[controller.selectedIndex];
          }),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.black,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child: GetBuilder<Controller>(
            id: 'indexchange',
            builder: (controller) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: controller.onItemTapped,
                currentIndex: controller.selectedIndex,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      activeIcon: Icon(Icons.home, color: Colors.white),
                      label: ''),
                  // BottomNavigationBarItem(
                  //     icon: Icon(
                  //       Icons.search,
                  //       color: Colors.grey,
                  //     ),
                  //     activeIcon: Icon(
                  //       Icons.search,
                  //       color: Colors.white,
                  //     ),
                  //     label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.grey,
                      ),
                      activeIcon:
                          Icon(Icons.shopping_cart, color: Colors.white),
                      label: ''),
                  // BottomNavigationBarItem(
                  //     icon: Icon(
                  //       Icons.analytics_outlined,
                  //       color: Colors.grey,
                  //     ),
                  //     activeIcon:
                  //         Icon(Icons.analytics_outlined, color: Colors.white),
                  //     label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.receipt_outlined,
                        color: Colors.grey,
                      ),
                      activeIcon:
                          Icon(Icons.receipt_outlined, color: Colors.white),
                      label: ''),
                ],
              );
            }),
      ),
    ));
  }
}
