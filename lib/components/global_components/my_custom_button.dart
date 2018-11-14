import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final Function callbackFunction;
  final String text;

  MyCustomButton({this.callbackFunction, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Theme.of(context).primaryColorDark,
        textColor: Theme.of(context).primaryColorLight,
        child: Text(
          text,
          textScaleFactor: 1.5,
        ),
        onPressed: () {
          callbackFunction();
        },
      ),
    );
  }
}
