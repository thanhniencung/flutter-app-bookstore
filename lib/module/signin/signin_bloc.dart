import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_app_book_store/base/base_bloc.dart';
import 'package:flutter_app_book_store/base/base_event.dart';
import 'package:flutter_app_book_store/data/repo/user_repo.dart';
import 'package:flutter_app_book_store/event/signin_fail_event.dart';
import 'package:flutter_app_book_store/event/signin_sucess_event.dart';
import 'package:flutter_app_book_store/event/singin_event.dart';
import 'package:flutter_app_book_store/shared/model/user_data.dart';
import 'package:flutter_app_book_store/shared/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc extends BaseBloc {
  final _phoneSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  final _userSubject = BehaviorSubject<UserData>();

  UserRepo _userRepo;

  SignInBloc({@required UserRepo userRepo}) {
    _userRepo = userRepo;
    validateForm();
  }

  var phoneValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (Validation.isPhoneValid(phone)) {
      sink.add(null);
      return;
    }
    sink.add('Phone invalid');
  });

  var passValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    if (Validation.isPassValid(pass)) {
      sink.add(null);
      return;
    }
    sink.add('Password too short');
  });

  Stream<String> get phoneStream =>
      _phoneSubject.stream.transform(phoneValidation);
  Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String> get passStream =>
      _passSubject.stream.transform(passValidation);
  Sink<String> get passSink => _passSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  Stream<UserData> get userStream => _userSubject.stream;
  Sink<UserData> get userSink => _userSubject.sink;

  validateForm() {
    Observable.combineLatest2(
      _phoneSubject,
      _passSubject,
      (phone, pass) {
        return Validation.isPhoneValid(phone) && Validation.isPassValid(pass);
      },
    ).listen((enable) {
      btnSink.add(enable);
    });
  }

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SignInEvent:
        handleSignIn(event);
        break;
    }
  }

  handleSignIn(event) {
    btnSink.add(false); //Khi bắt đầu call api thì disable nút sign-in
    loadingSink.add(true); // show loading

    Future.delayed(Duration(seconds: 6), () {
      SignInEvent e = event as SignInEvent;
      _userRepo.signIn(e.phone, e.pass).then(
        (userData) {
          processEventSink.add(SignInSuccessEvent(userData));
        },
        onError: (e) {
          print(e);
          btnSink.add(true); //Khi có kết quả thì enable nút sign-in trở lại
          loadingSink.add(false); // hide loading
          processEventSink
              .add(SignInFailEvent(e.toString())); // thông báo kết quả
        },
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _phoneSubject.close();
    _passSubject.close();
    _btnSubject.close();
    _userSubject.close();
  }
}
