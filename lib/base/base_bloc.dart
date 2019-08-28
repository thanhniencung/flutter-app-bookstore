import 'dart:async';
import 'package:flutter/widgets.dart';

import 'base_event.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get event => _eventStreamController.sink;

  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception("Invalid event");
      }

      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event);

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
}
