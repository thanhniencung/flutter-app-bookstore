import 'package:flutter/material.dart';
import 'package:flutter_app_book_store/shared/app_color.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;

  final List<SingleChildCloneableWidget> bloc;
  final List<SingleChildCloneableWidget> di;
  final List<Widget> actions;

  PageContainer({this.title, this.bloc, this.di, this.actions, this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...di,
        ...bloc,
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(color: AppColor.blue),
          ),
          actions: actions,
        ),
        body: child,
      ),
    );
  }
}

class NavigatorProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[],
      ),
    );
  }
}
