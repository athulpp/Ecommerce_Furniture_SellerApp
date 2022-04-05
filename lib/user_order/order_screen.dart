import 'package:flutter/material.dart';

import 'order_list_view.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'User orders record',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body:OrderListView() ,
    );
  }
}
