import 'package:dream_keeper/model/idea.dart';
import 'package:flutter/material.dart';

class ContentHome extends StatelessWidget {
  final int _ideasListCount;
  final List<Idea> _ideasList;
  final Function _getPriorityColor;
  final Function _getPriorityIcon;
  final Function _deleteIdea;
  final Function _navigateToDetailsPage;

  ContentHome(
    this._ideasListCount,
    this._ideasList,
    this._getPriorityColor,
    this._getPriorityIcon,
    this._deleteIdea,
    this._navigateToDetailsPage,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _ideasListCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getPriorityColor(
                  _ideasList[position].priority,
                ),
                child: _getPriorityIcon(
                  _ideasList[position].priority,
                ),
              ),
              title: Text(
                _ideasList[position].title,
                style: Theme.of(context).textTheme.subhead,
              ),
              subtitle: Text(_ideasList[position].date),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  _deleteIdea(context, _ideasList[position]);
                },
              ),
              onTap: () {
                debugPrint('ListTile Tapped');
                _navigateToDetailsPage(_ideasList[position], 'Edit Idea');
              },
            ),
          );
        },
      ),
    );
  }
}
