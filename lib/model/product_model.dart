import 'dart:typed_data';

class Product {
  final String productName;
  final String ProductDescripition;
  String? id;
  final String prdouctPrice;
  final String productQuantity;
  final   productImage;
  Product(
      {required this.productName,
      required this.ProductDescripition,
      this.id,
      required this.prdouctPrice,
      required this.productQuantity,
     this.productImage});
  Map<String, dynamic> toJson() => {
        'productname': productName,
        'productdes': ProductDescripition,
        'id': id,
        'productprice': prdouctPrice,
        'productquantity': productQuantity,
        'productimage': productImage,
      };
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
        productName: json['productname'],
        ProductDescripition: json['prdouctPrice'],
        id: json['id'],
        prdouctPrice: json['productprice'],
        productQuantity: json['productquantity'],
        productImage: json['productimage']);
  }
}
