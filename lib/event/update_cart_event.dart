import 'package:flutter_app_book_store/base/base_event.dart';
import 'package:flutter_app_book_store/shared/model/product.dart';

class UpdateCartEvent extends BaseEvent {
  Product product;
  UpdateCartEvent(this.product);
}
