import 'package:flutter/widgets.dart';
import 'package:flutter_app_book_store/base/base_bloc.dart';
import 'package:flutter_app_book_store/base/base_event.dart';
import 'package:flutter_app_book_store/data/repo/order_repo.dart';
import 'package:flutter_app_book_store/event/confirm_order_event.dart';
import 'package:flutter_app_book_store/event/pop_event.dart';
import 'package:flutter_app_book_store/event/rebuild_event.dart';
import 'package:flutter_app_book_store/event/update_cart_event.dart';
import 'package:flutter_app_book_store/shared/model/order.dart';

class CheckoutBloc extends BaseBloc {
  final OrderRepo _orderRepo;

  CheckoutBloc({
    @required OrderRepo orderRepo,
  }) : _orderRepo = orderRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case UpdateCartEvent:
        handleUpdateCart(event);
        break;
      case ConfirmOrderEvent:
        handleConfirmOrder(event);
        break;
    }
  }

  handleConfirmOrder(event) {
    _orderRepo.confirmOrder().then((isSuccess) {
      processEventSink.add(ShouldPopEvent());
    });
  }

  handleUpdateCart(event) {
    UpdateCartEvent e = event as UpdateCartEvent;
    _orderRepo.updateOrder(e.product).then((isSuccess) {
      if (isSuccess) {
        processEventSink.add(ShouldRebuildEvent());
      }
    });
  }

  Stream<Order> getOrderDetail() {
    return Stream<Order>.fromFuture(
      _orderRepo.getOrderDetail(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
