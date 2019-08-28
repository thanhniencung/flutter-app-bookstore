import 'package:flutter/material.dart';
import 'package:flutter_app_book_store/base/base_widget.dart';
import 'package:flutter_app_book_store/data/remote/user_service.dart';
import 'package:flutter_app_book_store/data/repo/user_repo.dart';
import 'package:flutter_app_book_store/event/singin_event.dart';
import 'package:flutter_app_book_store/module/signin/signin_bloc.dart';
import 'package:flutter_app_book_store/shared/app_color.dart';
import 'package:flutter_app_book_store/shared/widget/normal_button.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Sign In',
      di: [
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          builder: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
      ],
      bloc: [],
      child: SignInFormWidget(),
    );
  }
}

class SignInFormWidget extends StatelessWidget {
  final TextEditingController _txtPhoneController = TextEditingController();
  final TextEditingController _txtPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Provider<SignInBloc>.value(
      value: SignInBloc(userRepo: Provider.of(context)),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, child) => Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildPhoneField(bloc),
              _buildPassField(bloc),
              buildSignInButton(bloc),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSignInButton(SignInBloc bloc) {
    return StreamProvider<bool>.value(
      initialData: false,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => NormalButton(
          onPressed: enable
              ? () {
                  bloc.event.add(
                    SignInEvent(
                      phone: _txtPhoneController.text,
                      pass: _txtPassController.text,
                    ),
                  );
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.all(10),
        child: Text(
          'Đăng ký tài khoản',
          style: TextStyle(color: AppColor.blue, fontSize: 19),
        ),
      ),
    );
  }

  Widget _buildPhoneField(SignInBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.phoneStream,
      child: Consumer<String>(
        builder: (context, msg, child) => Container(
          margin: EdgeInsets.only(bottom: 15),
          child: TextField(
            controller: _txtPhoneController,
            onChanged: (text) {
              bloc.phoneSink.add(text);
            },
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.phone,
                  color: AppColor.blue,
                ),
                hintText: '(+84) 973 901 789',
                errorText: msg,
                labelText: 'Phone',
                labelStyle: TextStyle(color: AppColor.blue)),
          ),
        ),
      ),
    );
  }

  Widget _buildPassField(SignInBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.passStream,
      child: Consumer<String>(
        builder: (context, msg, child) => Container(
          margin: EdgeInsets.only(bottom: 25),
          child: TextField(
            controller: _txtPassController,
            onChanged: (text) {
              bloc.passSink.add(text);
            },
            obscureText: true,
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: AppColor.blue,
              ),
              hintText: 'Password',
              errorText: msg,
              labelText: 'Password',
              labelStyle: TextStyle(color: AppColor.blue),
            ),
          ),
        ),
      ),
    );
  }
}
