import 'package:flutter_app_book_store/shared/model/product.dart';

class ShoppingCart {
  String orderId;
  int total;
  List<Product> productList;

  ShoppingCart({this.orderId, this.total, this.productList});

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => ShoppingCart(
        orderId: json['orderId'] ?? '',
        total: json["total"],
      );
}
