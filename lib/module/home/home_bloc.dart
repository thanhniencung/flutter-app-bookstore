import 'package:flutter/widgets.dart';
import 'package:flutter_app_book_store/base/base_bloc.dart';
import 'package:flutter_app_book_store/base/base_event.dart';
import 'package:flutter_app_book_store/data/repo/order_repo.dart';
import 'package:flutter_app_book_store/data/repo/product_repo.dart';
import 'package:flutter_app_book_store/data/repo/user_repo.dart';
import 'package:flutter_app_book_store/event/add_to_cart_event.dart';
import 'package:flutter_app_book_store/shared/model/shopping_cart.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  final ProductRepo _productRepo;
  final OrderRepo _orderRepo;

  static HomeBloc _instance;

  static HomeBloc getInstance({
    @required ProductRepo productRepo,
    @required OrderRepo orderRepo,
  }) {
    if (_instance == null) {
      _instance = HomeBloc._internal(
        productRepo: productRepo,
        orderRepo: orderRepo,
      );
    }
    return _instance;
  }

  HomeBloc._internal({
    @required ProductRepo productRepo,
    @required OrderRepo orderRepo,
  })  : _productRepo = productRepo,
        _orderRepo = orderRepo;

  final _shoppingCardSubject = BehaviorSubject<AddToCartEvent>();

  Stream<AddToCartEvent> get shoppingCartStream => _shoppingCardSubject.stream;
  Sink<AddToCartEvent> get shoppingCartSink => _shoppingCardSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case AddToCartEvent:
        handleAddToCart(event);
        break;
    }
  }

  static int count = 0;
  handleAddToCart(event) {
    count++;
    print(count.toString());
    var addToCart = AddToCartEvent(count);
    shoppingCartSink.add(addToCart);
  }

  @override
  void dispose() {
    super.dispose();
    _shoppingCardSubject.close();
  }
}
