import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.of(context).pushReplacement(MaterialPageRoute(
        //         builder: (BuildContext context) => BottomNavigation()));
        //   },
        // ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Container(
                  width: double.infinity,
                  height: 320,
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: new NetworkImage(
                              "https://m.media-amazon.com/images/I/71+xw4gRDDL._SX569_.jpg"))))),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text('Minimal Stand '),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("₹ 5000"),
                // Row(
                //   children: [
                //     IconButton(
                //       onPressed: () {},
                //       icon: Icon(Icons.add),
                //     ),
                //     Text('1'),
                //     IconButton(
                //       onPressed: () {},
                //       icon: Icon(Icons.remove),
                //     ),
                //     IconButton(
                //         onPressed: () {}, icon: Icon(Icons.list_alt_outlined))
                //   ],
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
                'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. '),
          ),
          // CustomButton(
          //   onPressed: () {
          //     Get.to(() => SucessScreen());
          //   },
          //   text: 'Add To Cart',
          // )
        ],
      ),
    );
  }
}
