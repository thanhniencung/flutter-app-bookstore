import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_book_store/data/remote/order_service.dart';
import 'package:flutter_app_book_store/shared/model/order.dart';
import 'package:flutter_app_book_store/shared/model/product.dart';
import 'package:flutter_app_book_store/shared/model/rest_error.dart';
import 'package:flutter_app_book_store/shared/model/shopping_cart.dart';

class OrderRepo {
  OrderService _orderService;
  String _orderId;

  OrderRepo({@required OrderService orderService, @required String orderId})
      : _orderService = orderService,
        _orderId = orderId;

  Future<ShoppingCart> addToCart(Product product) async {
    var c = Completer<ShoppingCart>();
    try {
      var response = await _orderService.addToCart(product);
      var shoppingCart = ShoppingCart.fromJson(response.data['data']);
      c.complete(shoppingCart);
    } on DioError {
      c.completeError(RestError.fromData('Lỗi AddToCart'));
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
      c.completeError(RestError.fromData('Lỗi lấy thông tin shopping cart'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<Order> getOrderDetail() async {
    var c = Completer<Order>();
    try {
      var response = await _orderService.orderDetail(_orderId);
      if (response.data['data']['items'] != null) {
        var order = Order.fromJson(response.data['data']);
        c.complete(order);
      } else {
        c.completeError(RestError.fromData('Không lấy được đơn hàng'));
      }
    } on DioError {
      c.completeError(RestError.fromData('Không lấy được đơn hàng'));
    } catch (e) {
      c.completeError(RestError.fromData(e.toString()));
    }
    return c.future;
  }

  Future<bool> updateOrder(Product product) async {
    var c = Completer<bool>();
    try {
      await _orderService.updateOrder(product);
      c.complete(true);
    } on DioError {
      c.completeError(RestError.fromData('Lỗi update đơn hàng'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<bool> confirmOrder() async {
    var c = Completer<bool>();
    try {
      await _orderService.confirm(_orderId);
      c.complete(true);
    } on DioError {
      c.completeError(RestError.fromData('Lỗi confirm đơn hàng'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
