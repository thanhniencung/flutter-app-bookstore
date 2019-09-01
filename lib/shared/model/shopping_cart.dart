class ShoppingCart {
  String orderId;
  int total;

  ShoppingCart({this.orderId, this.total});

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => ShoppingCart(
        orderId: json['orderId'] ?? '',
        total: json["total"] ?? 0,
      );
}
