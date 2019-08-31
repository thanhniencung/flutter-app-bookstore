import 'package:dio/dio.dart';
import 'package:flutter_app_book_store/network/book_client.dart';
import 'package:flutter_app_book_store/shared/model/product.dart';

class OrderService {
  Future<Response> countShoppingCart() {
    return BookClient.instance.dio.get(
      '/order/count',
    );
  }

  Future<Response> addToCart(Product product) {
    return BookClient.instance.dio.post(
      '/order/add',
      data: product.toJson(),
    );
  }
}
