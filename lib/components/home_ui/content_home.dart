import 'package:dream_keeper/model/idea.dart';
import 'package:flutter/material.dart';

class ContentHome extends StatelessWidget {
  final int _ideasListCount;
  final List<Idea> _ideasList;
  final Function _deleteIdea;
  final Function _navigateToDetailsPage;

  ContentHome(
    this._ideasListCount,
    this._ideasList,
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
            margin: EdgeInsets.only(
              top: 10.0,
              left: 20.0,
              right: 20.0,
            ),
            color: Colors.white,
            elevation: 4.0,
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.lightbulb_outline),
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black87,
                radius: 25.0,
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
