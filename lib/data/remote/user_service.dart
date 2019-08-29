import 'package:dio/dio.dart';
import 'package:flutter_app_book_store/network/book_client.dart';

class UserService {
  Future<Response> signIn(String phone, String pass) {
    return BookClient.instance.dio.post(
      '/user/sign-in',
      data: {
        'phone': phone,
        'password': pass,
      },
    );
  }

  Future<Response> signUp(String displayName, String phone, String pass) {
    return BookClient.instance.dio.post(
      '/user/sign-up',
      data: {
        'displayName': displayName,
        'phone': phone,
        'password': pass,
      },
    );
  }
}
