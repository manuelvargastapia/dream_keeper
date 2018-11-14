import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/idea_details_ui/priority_dropdown.dart';
import '../components/idea_details_ui/record_audio_listtile.dart';
import '../components/idea_details_ui/idea_details_form.dart';
import '../components/global_components/my_custom_button.dart';
import '../data/db_helper.dart';
import '../model/idea.dart';

class IdeaDetailsPage extends StatefulWidget {
  final String _appBarTitle;
  final Idea _idea;

  IdeaDetailsPage(this._idea, this._appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return IdeaDetailsPageState(this._idea, this._appBarTitle);
  }
}

class IdeaDetailsPageState extends State<IdeaDetailsPage> {
  final String _appBarTitle;
  final DatabaseHelper _helper = DatabaseHelper();
  static final List<String> _priorities = ['High', 'Low'];
  final Idea _idea;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController valuePropositionController =
      TextEditingController();

  IdeaDetailsPageState(this._idea, this._appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    titleController.text = _idea.title;
    descriptionController.text = _idea.description;
    problemController.text = _idea.problemToSolve;
    customerController.text = _idea.customerSegment;
    valuePropositionController.text = _idea.valueProposition;

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                PriorityDropDown(
                  textStyle,
                  _idea,
                  _priorities,
                  getPriorityAsString,
                  updatePriorityAsInt,
                ),
                RecordAudioListTile(
                  updateRecordedAudioPath,
                  _idea,
                ),
              ],
            ),
            IdeaDetailsForm(
              textStyle,
              titleController,
              descriptionController,
              problemController,
              customerController,
              valuePropositionController,
              updateTitle,
              updateDescription,
              updateProblemToSolve,
              updateCustomerSegment,
              updateValueProposition,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  MyCustomButton(
                    callbackFunction: _saveIdea,
                    text: 'Save',
                  ),
                  SizedBox(width: 5.0),
                  MyCustomButton(
                    callbackFunction: _deleteIdea,
                    text: 'Delete',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updatePriorityAsInt(String value) {
    setState(() {
      switch (value) {
        case 'High':
          _idea.priority = 1;
          break;
        case 'Low':
          _idea.priority = 2;
          break;
      }
    });
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  Future<String> _loadRecordedAudioPathPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String recAudioPath = sharedPreferences.getString('RecAudioPath');
    return recAudioPath;
  }

  void updateRecordedAudioPath() {
    _loadRecordedAudioPathPref().then(
      (String returnValue) {
        debugPrint(
          '[IdeaDetailsPage] ShPref loaded: $returnValue',
        );
        setState(() => _idea.recAudioPath = returnValue);
      },
    );
  }

  void updateTitle() {
    _idea.title = titleController.text;
  }

  void updateDescription() {
    _idea.description = descriptionController.text;
  }

  void updateProblemToSolve() {
    _idea.problemToSolve = problemController.text;
  }

  void updateCustomerSegment() {
    _idea.customerSegment = customerController.text;
  }

  void updateValueProposition() {
    _idea.valueProposition = valuePropositionController.text;
  }

  void _saveIdea() async {
    _idea.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (_idea.id != null) {
      result = await _helper.updateIdea(_idea);
    } else {
      result = await _helper.insertIdea(_idea);
    }
    moveToLastScreen();
    if (result != 0) {
      _showAlertDialog('Status', 'Idea Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Idea');
    }
  }

  void _deleteIdea() async {
    moveToLastScreen();
    if (_idea.id == null) {
      _showAlertDialog('Status', 'No Idea was deleted');
      return;
    }
    int result = await _helper.deleteIdea(_idea.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Idea Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Idea');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
    );
  }
}
