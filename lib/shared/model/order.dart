import 'package:flutter_app_book_store/shared/model/product.dart';

class Order {
  double total;
  List<Product> items;

  Order({this.total, this.items});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        total: double.parse(json["total"]?.toString()),
        items: parseProductList(json),
      );

  static List<Product> parseProductList(map) {
    var list = map['items'] as List;
    return list.map((product) => Product.fromJson(product)).toList();
  }
}
