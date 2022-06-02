import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller/model/address.dart';
import 'package:seller/model/cart.dart';

class Order {
  String? orderId;
  String? userId;
  Timestamp createdDate;
  Cart cart;
  Address address;
  String status;
  double totalPrice;

  Order({
    required this.orderId,
    required this.userId,
    required this.createdDate,
    required this.cart,
    required this.address,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'userId':userId,
      'createdDate': createdDate,
      'cart': cart.toMap(),
      'address': address.toJson(),
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(dynamic map) {
  

    return Order(
      orderId: map['orderId'] ?? "",
      userId: map['userId'] ?? "",
      createdDate: map['createdDate'] ?? "",
      cart: Cart.fromMap(map['cart'] as Map<String, dynamic>),
      address: Address.fromJson(map['address'] as Map<String, dynamic>),
      status: map['status'] ?? "" as String,
      totalPrice: map['totalPrice'] ?? 0.0 as double,
    );
  }
}
