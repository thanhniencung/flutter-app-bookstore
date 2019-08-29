import 'package:flutter/widgets.dart';
import 'package:flutter_app_book_store/base/base_event.dart';

class SignInEvent extends BaseEvent {
  String phone;
  String pass;

  SignInEvent({
    @required this.phone,
    @required this.pass,
  });
}
