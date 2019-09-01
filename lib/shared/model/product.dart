/*
"data": {
        "productId": "25ce65d4-cbfc-11e9-b50c-8c8590cefb77",
        "productName": "THÓI QUEN CỦA MẸ NUÔI CON TỰ GIÁC HỌC TẬP",
        "productImage": "https://cdn0.fahasa.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/t/h/thoi_quen_day_con_tu_giac_hoc_tap-01.jpg",
        "quantity": 40,
        "soldItems": 0,
        "price": 600000,
    }
 */
class Product {
  String orderId;
  String productId;
  String productName;
  String productImage;
  int quantity;
  int soldItems;
  double price;

  Product({
    this.orderId,
    this.productId,
    this.productName,
    this.productImage,
    this.quantity,
    this.soldItems,
    this.price,
  });

  static List<Product> parseProductList(map) {
    var list = map['data'] as List;
    return list.map((product) => Product.fromJson(product)).toList();
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        orderId: json["orderId"] ?? '',
        productId: json["productId"],
        productName: json["productName"],
        productImage: json["productImage"],
        quantity: int.parse(json["quantity"].toString()),
        price: double.tryParse(json['price'].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "quantity": quantity,
        "price": price,
      };
}
