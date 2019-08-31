import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_book_store/data/remote/order_service.dart';
import 'package:flutter_app_book_store/shared/model/product.dart';
import 'package:flutter_app_book_store/shared/model/shopping_cart.dart';

class OrderRepo {
  OrderService _orderService;

  OrderRepo({@required OrderService orderService})
      : _orderService = orderService;

  Future<ShoppingCart> addToCart(Product product) async {
    var c = Completer<ShoppingCart>();
    try {
      var response = await _orderService.addToCart(product);
      var shoppingCart = ShoppingCart.fromJson(response.data['data']);
      c.complete(shoppingCart);
    } on DioError {
      c.completeError('Lỗi đặt hàng');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<ShoppingCart> getShoppingCartInfo() async {
    var c = Completer<ShoppingCart>();
    try {
      var response = await _orderService.countShoppingCart();
      var shoppingCart = ShoppingCart.fromJson(response.data['data']);
      c.complete(shoppingCart);
    } on DioError {
      c.completeError('Lỗi đơn hàng');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
