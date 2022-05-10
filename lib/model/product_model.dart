import 'dart:typed_data';

class Product {
  final String productName;
  final String ProductDescripition;
  String? id;
  final String prdouctPrice;
  final String productQuantity;
  // final String productCategory;
  final productImage;
  Product(
      {required this.productName,
      required this.ProductDescripition,
      this.id,
      required this.prdouctPrice,
      required this.productQuantity,
      // required this.productCategory,
      this.productImage});
  Map<String, dynamic> toJson() => {
        'productname': productName,
        'productdes': ProductDescripition,
        'id': id,
        'productprice': prdouctPrice,
        'productquantity': productQuantity,
        // 'productCategory': productCategory,
        'productimage': productImage,
      };
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
        productName: json['productname'],
        ProductDescripition: json['prdouctPrice'],
        id: json['id'],
        prdouctPrice: json['productprice'],
        productQuantity: json['productquantity'],
        // productCategory: json['productCategory'],
        productImage: json['productimage']);
  }
}
