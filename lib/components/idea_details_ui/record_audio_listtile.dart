import 'package:dream_keeper/model/idea.dart';
import 'package:flutter/material.dart';
import 'package:dream_keeper/pages/record_audio_page.dart';

class RecordAudioListTile extends StatelessWidget {
  final Function updateRecordedAudioPath;
  final Idea idea;

  RecordAudioListTile(this.updateRecordedAudioPath, this.idea);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: ListTile(
        leading: Icon(
          Icons.keyboard_voice,
          color: Colors.red,
          size: 35.0,
        ),
        title: Text(
          'Record Audio',
          textScaleFactor: 1.5,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return RecordAudioPage(
                updateRecordedAudioPath,
                idea,
              );
            }),
          );
        },
      ),
    );
  }
}
