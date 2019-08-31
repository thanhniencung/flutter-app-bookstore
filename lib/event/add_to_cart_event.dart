import 'package:flutter_app_book_store/base/base_event.dart';

class AddToCartEvent extends BaseEvent {
  int count;
  AddToCartEvent(this.count);
}
