import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller/login/login_screen.dart';

import 'controller.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOption = [
      // HomeScreen(),
      // SeachScreen(),
      // WishList(),
      // OrdersScreen(),
      // UserProfileScreen()
    ];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('furniture'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(LoginScreen());
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
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      activeIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.bookmark_border,
                        color: Colors.grey,
                      ),
                      activeIcon:
                          Icon(Icons.bookmark_border, color: Colors.white),
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
                        Icons.person,
                        color: Colors.grey,
                      ),
                      activeIcon: Icon(Icons.person, color: Colors.white),
                      label: ''),
                ],
              );
            }),
      ),
    ));
  }
}
