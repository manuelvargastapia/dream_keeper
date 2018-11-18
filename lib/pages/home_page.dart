import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../model/idea.dart';
import '../data/db_helper.dart';
import '../components/home_ui/content_home.dart';
import '../components/home_ui/fab_home.dart';
import 'edit_idea_page.dart';

class HomePage extends StatefulWidget {
  static const String pageRoute = '/';
  static const String _pageTitle = 'Dream Keeper';
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Idea> _ideasList;
  int _ideasListCount = 0;

  @override
  Widget build(BuildContext context) {
    if (_ideasList == null) {
      _ideasList = List<Idea>();
      _updateIdeasListToShow();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          HomePage._pageTitle,
          textScaleFactor: 1.3,
        ),
      ),
      body: ContentHome(
        _ideasListCount,
        _ideasList,
        _deleteIdea,
        _navigateToDetailsPage,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FABHome(_navigateToDetailsPage),
    );
  }

  void _updateIdeasListToShow() {
    final Future<Database> myDatabase = _databaseHelper.initializeDatabase();
    myDatabase.then((Database myDatabase) {
      Future<List<Idea>> _ideaListFuture = _databaseHelper.getIdeasList();
      _ideaListFuture.then((List<Idea> myIdeasList) {
        setState(() {
          this._ideasList = myIdeasList;
          this._ideasListCount = myIdeasList.length;
        });
      });
    });
  }

  void _deleteIdea(BuildContext context, Idea idea) async {
    int deletedIdeasCount = await _databaseHelper.deleteIdea(idea.id);
    if (deletedIdeasCount != 0) {
      _showSnackBar(context, 'Idea Deleted Successfully');
      _updateIdeasListToShow();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _navigateToDetailsPage(Idea idea, String title) async {
    bool succesfulNavigation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return EditIdeaPage(idea, title);
      }),
    );
    if (succesfulNavigation == true) {
      _updateIdeasListToShow();
    }
  }
}
