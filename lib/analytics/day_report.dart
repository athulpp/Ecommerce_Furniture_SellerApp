import 'package:flutter/material.dart';

class DayReport extends StatelessWidget {
  const DayReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // separatorBuilder: (BuildContext context, int index) => const Divider(
      //   thickness: 5,
      // ),
      itemCount: 15,
      itemBuilder: (BuildContext context, index) {
        return Container(
          height: 100,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Card(
              color: Colors.grey.shade200,
              child: ListTile(
                leading: Text('Product name'),
                
                title: Text('No.of product sales '),
                trailing: Text('total money earned'),
              ),
            ),
          ),
        );
      },
    );
  }
}
