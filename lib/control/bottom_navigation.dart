import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller/add_product/new_product.dart';
import 'package:seller/home/all_products.dart';


import '../user_order/order_screen.dart';
import 'controller.dart';

// ignore: non_constant_identifier_names
final data_control = Get.put(Controller());

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key, this.currentIndex}) : super(key: key);
  List<String> headings = [
    'Product List',
    'Add Product',
    'User Order Screen',
  ];
  int? currentIndex;
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOption = [
      AllProductList(),

      NewProductScreen(),

     const OrderScreen()
  
    ];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(

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
            PopupMenuButton(
              itemBuilder: ((BuildContext context) {
                return <PopupMenuItem>[
                  PopupMenuItem(
                      child: GestureDetector(
                          child:const Text('Logout'),
                          onTap: () {
                            Get.defaultDialog(
                                buttonColor: Colors.white,
                                barrierDismissible: true,
                                title: 'Logout',
                                titleStyle:const TextStyle(fontSize: 18),
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
                                });
                          })),
                  PopupMenuItem(
                      child: GestureDetector(
                    child:const Text('Privacy Policies'),
                    onTap: () {
                      showAboutDialog(
                          applicationIcon: Image.asset(
                            'assests/images/Group.png',
                            width: 70,
                            height: 70,
                          ),
                          context: context,
                          applicationName: 'Furnidesk',
                          applicationVersion: '1.1.0',
                          children: [
                            const Text(
                                "Furnidesk is a Tables Ecommerce Platform Created by Athul"),
                          ]);
                    },
                  ))
                ];
              }),
            )
          ]),


      body: GetBuilder<Controller>(
          init: Controller(),
          id: 'indexchange',
          builder: (controller) {
            return _widgetOption[controller.selectedIndex];
          }),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
 
            canvasColor: Colors.black,
           
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: const TextStyle(color: Colors.yellow))),
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

                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.grey,
                      ),
                      activeIcon:
                          Icon(Icons.shopping_cart, color: Colors.white),
                      label: ''),
              
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
