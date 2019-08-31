import 'package:flutter/widgets.dart';
import 'package:flutter_app_book_store/data/remote/order_service.dart';

class OrderRepo {
  OrderService _orderService;

  OrderRepo({@required OrderService orderService})
      : _orderService = orderService;
}
