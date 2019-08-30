import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_app_book_store/base/base_bloc.dart';
import 'package:flutter_app_book_store/base/base_event.dart';
import 'package:flutter_app_book_store/data/repo/user_repo.dart';
import 'package:flutter_app_book_store/event/signup_event.dart';
import 'package:flutter_app_book_store/event/signup_fail_event.dart';
import 'package:flutter_app_book_store/event/signup_sucess_event.dart';
import 'package:flutter_app_book_store/shared/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends BaseBloc {
  final _displayNameSubject = BehaviorSubject<String>();
  final _phoneSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  UserRepo _userRepo;

  SignUpBloc({@required UserRepo userRepo}) {
    _userRepo = userRepo;
    validateForm();
  }

  var displayNameValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (displayName, sink) {
    if (Validation.isDisplayNameValid(displayName)) {
      sink.add(null);
      return;
    }
    sink.add('Display name too short');
  });

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

  Stream<String> get displayNameStream =>
      _displayNameSubject.stream.transform(displayNameValidation);
  Sink<String> get displayNameSink => _displayNameSubject.sink;

  Stream<String> get phoneStream =>
      _phoneSubject.stream.transform(phoneValidation);
  Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String> get passStream =>
      _passSubject.stream.transform(passValidation);
  Sink<String> get passSink => _passSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

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
      case SignUpEvent:
        handleSignUp(event);
        break;
    }
  }

  handleSignUp(event) {
    btnSink.add(false);
    loadingSink.add(true); // show loading

    Future.delayed(Duration(seconds: 6), () {
      SignUpEvent e = event as SignUpEvent;
      _userRepo.signUp(e.displayName, e.phone, e.pass).then(
        (userData) {
          processEventSink.add(SignUpSuccessEvent(userData));
        },
        onError: (e) {
          btnSink.add(true);
          loadingSink.add(false);
          processEventSink.add(SignUpFailEvent(e.toString()));
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();

    _displayNameSubject.close();
    _phoneSubject.close();
    _passSubject.close();
    _btnSubject.close();
  }
}
