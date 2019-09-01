import 'package:flutter/material.dart';

class BtnCartAction extends StatelessWidget {
  final title;
  final VoidCallback onPressed;

  BtnCartAction({@required this.onPressed, @required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42,
      height: 42,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0)),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
