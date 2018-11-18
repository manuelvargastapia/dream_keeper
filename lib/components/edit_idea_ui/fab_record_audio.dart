import 'package:flutter/material.dart';

class FABRecordAudio extends StatelessWidget {
  final Function _navigateToRecordAudioPage;

  FABRecordAudio(this._navigateToRecordAudioPage);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 3.0,
      child: FloatingActionButton(
        child: Icon(
          Icons.keyboard_voice,
          size: 30.0,
        ),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black87,
        onPressed: _navigateToRecordAudioPage,
      ),
    );
  }
}
