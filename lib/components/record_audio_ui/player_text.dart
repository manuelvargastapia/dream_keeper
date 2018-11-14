import 'package:flutter/material.dart';

class PlayerText extends StatelessWidget {
  final String _playerText;

  PlayerText(this._playerText);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 60.0, bottom: 16.0),
          child: Text(
            this._playerText,
            style: TextStyle(
              fontSize: 48.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
