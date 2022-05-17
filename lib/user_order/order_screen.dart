import 'package:flutter/material.dart';

import 'order_list_view.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
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
              icon: Icon(
                Icons.privacy_tip,
                color: Colors.grey,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: OrderListView(),
    );
  }
}
