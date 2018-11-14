import 'package:flutter/material.dart';
import 'package:dream_keeper/model/idea.dart';

class FABHome extends StatelessWidget {
  final Function _navigateToDetail;

  FABHome(this._navigateToDetail);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.yellowAccent,
      tooltip: 'Add Idea',
      label: Text(
        'New Idea',
        textScaleFactor: 1.4,
      ),
      icon: Icon(Icons.lightbulb_outline),
      onPressed: () {
        debugPrint('FAB clicked');
        _navigateToDetail(Idea('', ''), 'Add Idea');
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
