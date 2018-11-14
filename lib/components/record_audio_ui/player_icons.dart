import 'package:flutter/material.dart';

class PlayerIcons extends StatelessWidget {
  final bool _isPlaying;
  final String _startPlayerIcon;
  final String _pausePlayerIcon;
  final String _stopPlayerIcon;
  final Function _startPlayer;
  final Function _pausePlayer;
  final Function _stopPlayer;

  PlayerIcons(
    this._isPlaying,
    this._startPlayerIcon,
    this._pausePlayerIcon,
    this._stopPlayerIcon,
    this._startPlayer,
    this._pausePlayer,
    this._stopPlayer,
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
                if (_isPlaying) {
                  return _pausePlayer();
                }
                _startPlayer();
              },
              padding: EdgeInsets.all(8.0),
              child: _isPlaying
                  ? Image(
                      width: 28.0,
                      height: 28.0,
                      image: AssetImage(_pausePlayerIcon),
                    )
                  : Image(
                      image: AssetImage(_startPlayerIcon),
                    ),
            ),
          ),
        ),
        Container(
          width: 56.0,
          height: 56.0,
          child: ClipOval(
            child: FlatButton(
                onPressed: () => _stopPlayer(),
                padding: EdgeInsets.all(8.0),
                child: Image(
                  width: 28.0,
                  height: 28.0,
                  image: AssetImage(_stopPlayerIcon),
                )),
          ),
        ),
      ],
    );
  }
}
