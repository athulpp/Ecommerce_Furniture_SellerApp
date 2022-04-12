import 'package:flutter/material.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // separatorBuilder: (BuildContext context, int index) => const Divider(
      //   thickness: 2,
      // ),
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
