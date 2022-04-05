import 'package:flutter/material.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text('User Name'),
          title: Text('product Name'),
          subtitle: Text('item count'),
          trailing: Text('Date purcahsed'),
        );
      },
    );
  }
}
