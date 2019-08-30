import 'package:flutter/material.dart';
import 'package:flutter_app_book_store/base/base_event.dart';
import 'package:flutter_app_book_store/module/signin/signin_bloc.dart';
import 'package:provider/provider.dart';

class BlocListener extends StatefulWidget {
  final Widget child;
  final Function(BaseEvent event) listener;

  BlocListener({
    @required this.child,
    @required this.listener,
  });

  @override
  _BlocListenerState createState() => _BlocListenerState();
}

class _BlocListenerState extends State<BlocListener> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<SignInBloc>(context).processEventStream.listen(
      (event) {
        widget.listener(event);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<BaseEvent>.value(
      value: Provider.of<SignInBloc>(context).processEventStream,
      initialData: null,
      updateShouldNotify: (prev, current) {
        return false;
      },
      child: Consumer<BaseEvent>(
        builder: (context, event, child) {
          return Container(
            child: widget.child,
          );
        },
      ),
    );
  }
}
