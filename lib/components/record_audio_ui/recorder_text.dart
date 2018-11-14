import 'package:flutter/material.dart';

class RecorderText extends StatelessWidget {
  final String _recorderText;

  RecorderText(this._recorderText);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
          child: Text(
            _recorderText,
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
