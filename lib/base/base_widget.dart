import 'package:flutter/material.dart';
import 'package:flutter_app_book_store/data/remote/user_service.dart';
import 'package:flutter_app_book_store/data/repo/user_repo.dart';
import 'package:flutter_app_book_store/shared/app_color.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;

  final List<SingleChildCloneableWidget> bloc;
  final List<SingleChildCloneableWidget> di;

  PageContainer({this.title, this.bloc, this.di, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: AppColor.blue),
        ),
      ),
      body: MultiProvider(
        providers: [
          ...di,
          ...bloc,
        ],
        child: child,
      ),
    );
  }
}
