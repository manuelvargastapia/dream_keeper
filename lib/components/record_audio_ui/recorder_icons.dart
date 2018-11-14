import 'package:flutter/material.dart';

class RecorderIcon extends StatelessWidget {
  final bool _isRecording;
  final String _startRecIcon;
  final String _stopRecIcon;
  final Function _startRecorder;
  final Function _stopRecorder;

  RecorderIcon(
    this._isRecording,
    this._startRecIcon,
    this._stopRecIcon,
    this._startRecorder,
    this._stopRecorder,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          child: ClipOval(
            child: FlatButton(
              onPressed: () {
                if (_isRecording) {
                  return _stopRecorder();
                }
                _startRecorder();
              },
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: _isRecording
                    ? AssetImage(_stopRecIcon)
                    : AssetImage(_startRecIcon),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
