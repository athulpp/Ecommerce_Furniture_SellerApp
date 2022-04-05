import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller/home/product_detail.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, index) {
        return SingleChildScrollView(
          child: ListTile(
            onTap: () {
              Get.to(() => const ProductDetailScreen());
            },
            leading: Image.network(
                'https://m.media-amazon.com/images/I/71+xw4gRDDL._SX569_.jpg'),
            title: Text('product name'),
            subtitle: Text('Product price'),
            trailing: Wrap(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {}, icon: Icon(Icons.update))
              ],
            ),
          ),
        );
      },
    );
  }
}
