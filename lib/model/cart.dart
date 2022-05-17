class Cart {
  final cartId;
  String productName;
  String productDes;
  String productPrice;
  String ProductQuantity;
  String productImage;

  Cart(
      {this.cartId,
      required this.productName,
      required this.productDes,
      required this.productPrice,
      required this.ProductQuantity,
      required this.productImage});

  Map<String, dynamic> toJson() => {
        'id': cartId,
        "name": productName,
        'des': productDes,
        "price": productPrice,
        "quantity": ProductQuantity,
        "image": productImage
      };
  static Cart fromMap(dynamic json) {
      print(
        "orderId :   ${json['id']} status:    ${json['name']}  totalPrice:   ${json['des']} image:  ${json['image']} quantity:  ${json['quantity']} price ${json['price']} ");

    return Cart(
        cartId: json['id'],
        productName: json['name'],
        productDes: json['des'],
        productPrice: json['price'],
        ProductQuantity: json['quantity'],
        productImage: json['image']);
  }

  Map<String, dynamic> toMap() => {
        'id': cartId,
        "name": productName,
        'des': productDes,
        "price": productPrice,
        "quantity": ProductQuantity,
        "image": productImage
      };

}
