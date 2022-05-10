import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderListView extends StatelessWidget {
  OrderListView({Key? key}) : super(key: key);
  final _orderStream = FirebaseFirestore.instance
      .collection('OrderCollection')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('order')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Card(
            shadowColor: Colors.black,
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            color: Colors.grey.shade300,
            child: ListTile(
              leading: Text('User Name'),
              title: Text('product Name'),
              subtitle: Text('item count'),
              trailing: Text('Date purcahsed'),
            ),
          ),
        );
      },
    );
  }
}
