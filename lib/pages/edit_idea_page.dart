import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/edit_idea_ui/form/edit_idea_form.dart';
import '../components/edit_idea_ui/fab_record_audio.dart';
import '../data/db_helper.dart';
import '../model/idea.dart';
import 'record_audio_page.dart';

class EditIdeaPage extends StatefulWidget {
  final String _appBarTitle;
  final Idea _idea;

  EditIdeaPage(this._idea, this._appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return EditIdeaPageState(this._idea, this._appBarTitle);
  }
}

class EditIdeaPageState extends State<EditIdeaPage> {
  final String _appBarTitle;
  final DatabaseHelper _helper = DatabaseHelper();
  final Idea _idea;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController brainstormController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController solutionController = TextEditingController();
  final TextEditingController customersController = TextEditingController();
  final TextEditingController channelsController = TextEditingController();
  final TextEditingController activitiesController = TextEditingController();
  final TextEditingController uniqueValueController = TextEditingController();
  final TextEditingController costsController = TextEditingController();
  final TextEditingController revenuesController = TextEditingController();

  EditIdeaPageState(this._idea, this._appBarTitle);

  @override
  Widget build(BuildContext context) {
    titleController.text = _idea.title;
    brainstormController.text = _idea.brainstorm;
    problemController.text = _idea.problem;
    solutionController.text = _idea.solution;
    customersController.text = _idea.customers;
    channelsController.text = _idea.channels;
    activitiesController.text = _idea.activities;
    uniqueValueController.text = _idea.uniqueValue;
    costsController.text = _idea.costs;
    revenuesController.text = _idea.revenues;

    final Map<String, TextEditingController> textEditingControllerMap = {
      'title': titleController,
      'brainstorm': brainstormController,
      'problem': problemController,
      'solution': solutionController,
      'customers': customersController,
      'channels': channelsController,
      'activities': activitiesController,
      'uniqueValue': uniqueValueController,
      'costs': costsController,
      'revenues': revenuesController,
    };
    final Map<String, Function> updateFunctionMap = {
      'title': updateTitle,
      'brainstorm': updateBrainstorm,
      'problem': updateProblem,
      'solution': updateSolution,
      'customers': updateCustomers,
      'channels': updateChannels,
      'activities': updateActivities,
      'uniqueValue': updateUniqueValue,
      'costs': updateCosts,
      'revenues': updateRevenues,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              size: 40.0,
            ),
            color: Colors.white,
            onPressed: _saveIdea,
          ),
          SizedBox(width: 12.0),
          IconButton(
            icon: Icon(
              Icons.delete,
              size: 30.0,
            ),
            color: Colors.white,
            onPressed: _deleteIdea,
          ),
        ],
      ),
      body: EditIdeaForm(
        textEditingControllerMap,
        updateFunctionMap,
      ),
      floatingActionButton: FABRecordAudio(_navigateToRecordAudioPage),
    );
  }

  void _moveToLastScreen() {
    Navigator.pop(context, true);
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
          '[EditIdeaPage] ShPref loaded: $returnValue',
        );
        setState(() => _idea.recAudioPath = returnValue);
      },
    );
  }

  void updateTitle() {
    _idea.title = titleController.text;
  }

  void updateBrainstorm() {
    _idea.brainstorm = brainstormController.text;
  }

  void updateProblem() {
    _idea.problem = problemController.text;
  }

  void updateSolution() {
    _idea.solution = solutionController.text;
  }

  void updateCustomers() {
    _idea.customers = customersController.text;
  }

  void updateChannels() {
    _idea.channels = channelsController.text;
  }

  void updateActivities() {
    _idea.activities = activitiesController.text;
  }

  void updateUniqueValue() {
    _idea.uniqueValue = uniqueValueController.text;
  }

  void updateCosts() {
    _idea.costs = costsController.text;
  }

  void updateRevenues() {
    _idea.revenues = revenuesController.text;
  }

  void _saveIdea() async {
    _idea.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (_idea.id != null) {
      result = await _helper.updateIdea(_idea);
    } else {
      result = await _helper.insertIdea(_idea);
    }
    _moveToLastScreen();
    if (result != 0) {
      _showAlertDialog('Status', 'Idea Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Idea');
    }
  }

  void _deleteIdea() async {
    _moveToLastScreen();
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

  void _navigateToRecordAudioPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return RecordAudioPage(
          updateRecordedAudioPath,
          _idea,
        );
      }),
    );
  }
}
