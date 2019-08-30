import 'package:flutter_app_book_store/base/base_event.dart';
import 'package:flutter_app_book_store/shared/model/user_data.dart';

class SignInSuccessEvent extends BaseEvent {
  final UserData userData;
  SignInSuccessEvent(this.userData);
}
