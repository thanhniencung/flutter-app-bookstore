import 'package:flutter/material.dart';
import 'package:flutter_app_book_store/module/checkout/checkout_page.dart';
import 'package:flutter_app_book_store/module/home/home_page.dart';
import 'package:flutter_app_book_store/module/signin/signin_page.dart';
import 'package:flutter_app_book_store/module/signup/signup_page.dart';
import 'package:flutter_app_book_store/module/splash/splash.dart';
import 'package:flutter_app_book_store/shared/app_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: AppColor.yellow,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
        '/sign-in': (context) => SignInPage(),
        '/sign-up': (context) => SignUpPage(),
        '/checkout': (context) => CheckoutPage(),
      },
    );
  }
}
