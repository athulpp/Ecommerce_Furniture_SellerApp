import 'package:flutter/material.dart';

class MonthReport extends StatelessWidget {
  const MonthReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: 5,
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          leading: Text('Product name'),
          title: Text('No.of product sales '),
          trailing: Text('total money earned'),
        );
      },
    );
  }
}
