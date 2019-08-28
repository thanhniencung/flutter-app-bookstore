import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_app_book_store/base/base_bloc.dart';
import 'package:flutter_app_book_store/base/base_event.dart';
import 'package:flutter_app_book_store/data/repo/user_repo.dart';
import 'package:flutter_app_book_store/data/spref/spref.dart';
import 'package:flutter_app_book_store/event/signup_event.dart';
import 'package:flutter_app_book_store/event/singin_event.dart';
import 'package:flutter_app_book_store/shared/constant.dart';

class SignInBloc extends BaseBloc {
  final UserRepo _userRepo;

  SignInBloc({@required UserRepo userRepo}) : _userRepo = userRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SignInEvent:
        handleSignIn(event);
        break;

      case SignUpEvent:
        handleSignUp(event);
        break;
    }
  }

  handleSignIn(event) {
    SignInEvent e = event as SignInEvent;
    _userRepo.signIn(e.phone, e.pass).then(
      (userData) {
        print(userData);
      },
      onError: (e) {
        print(e);
      },
    );
  }

  handleSignUp(event) {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
