import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'dart:async';
import '../components/record_audio_ui/player_icons.dart';
import '../components/record_audio_ui/player_text.dart';
import '../components/record_audio_ui/recorder_icons.dart';
import '../components/record_audio_ui/recorder_text.dart';
import '../components/global_components/my_custom_button.dart';
import '../data/db_helper.dart';
import '../model/idea.dart';

class RecordAudioPage extends StatefulWidget {
  static const pageRoute = '/record_audio';
  final Function updateRecordedAudioPath;
  final Idea idea;

  RecordAudioPage(this.updateRecordedAudioPath, this.idea);

  @override
  _RecordAudioPageState createState() => _RecordAudioPageState();
}

class _RecordAudioPageState extends State<RecordAudioPage> {
  final String _pageTitle = 'Record Audio';
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isPaused = false;
  final String _stopRecIcon = 'assets/icons/ic_stop.png';
  final String _startRecIcon = 'assets/icons/ic_mic.png';
  final String _startPlayerIcon = 'assets/icons/ic_play.png';
  final String _pausePlayerIcon = 'assets/icons/ic_pause.png';
  final String _stopPlayerIcon = 'assets/icons/ic_stop.png';
  StreamSubscription _recorderSubscription;
  StreamSubscription _playerSubscription;
  String _recordedAudioPath;
  FlutterSound _flutterSound;
  String _recorderText = '00:00:00';
  String _playerText = '00:00:00';
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _flutterSound = FlutterSound();
    _flutterSound.setSubscriptionDuration(0.01);
    _recordedAudioPath = widget.idea.recAudioPath;
    debugPrint('[RecordAudioPage] initState path: $_recordedAudioPath');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            RecorderText(_recorderText),
            RecorderIcon(
              _isRecording,
              _startRecIcon,
              _stopRecIcon,
              _startRecorder,
              _stopRecorder,
            ),
            PlayerText(_playerText),
            PlayerIcons(
              _isPlaying,
              _startPlayerIcon,
              _pausePlayerIcon,
              _stopPlayerIcon,
              _startPlayer,
              _pausePlayer,
              _stopPlayer,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  MyCustomButton(
                    callbackFunction: _saveRecord,
                    text: 'Save',
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  MyCustomButton(
                    callbackFunction: _deleteRecord,
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

  void _startRecorder() async {
    try {
      await _generateNewRecAudioPath();
      String path = await _flutterSound.startRecorder(_recordedAudioPath);
      print('[RecordAudioPage] startRecorder: $path');
      _runRecordTimer();
    } catch (error) {
      debugPrint('[RecordAudioPage] startRecord error: $error');
    }
  }

  void _runRecordTimer() {
    _recorderSubscription = _flutterSound.onRecorderStateChanged.listen(
      (RecordStatus status) {
        DateTime currentPosition = DateTime.fromMillisecondsSinceEpoch(
          status.currentPosition.toInt(),
        );
        String currentTimer =
            DateFormat('mm:ss:SS', 'en_US').format(currentPosition);
        setState(() => _recorderText = currentTimer.substring(0, 8));
      },
    );
    setState(() => _isRecording = true);
  }

  void _stopRecorder() async {
    try {
      String recordStatus = await _flutterSound.stopRecorder();
      print('[RecordAudioPage] stopRecorder: $recordStatus');
      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
      setState(() => _isRecording = false);
    } catch (error) {
      debugPrint('[RecordAudioPage] stopRecorder error: $error');
    }
  }

  void _startPlayer() async {
    if (_isPaused) {
      _resumePlayer();
    } else {
      debugPrint('[RecordAudioPage] startPlayer: $_recordedAudioPath');
      String path = await _flutterSound.startPlayer(_recordedAudioPath);
      await _flutterSound.setVolume(1.0);
      debugPrint('[RecordAudioPage] startPlayer: $path');
      try {
        _runPlayerTimer();
      } catch (error) {
        debugPrint('startPlayer error: $error');
      }
    }
  }

  void _runPlayerTimer() {
    _playerSubscription = _flutterSound.onPlayerStateChanged.listen(
      (PlayStatus status) {
        if (status != null) {
          DateTime date = DateTime.fromMillisecondsSinceEpoch(
            status.currentPosition.toInt(),
          );
          String newText = DateFormat('mm:ss:SS', 'en_US').format(date);
          setState(() => _playerText = newText.substring(0, 8));
          if (status.currentPosition == status.duration) {
            setState(() => _isPlaying = false);
          }
        }
      },
    );
    setState(() {
      _isPlaying = true;
      _isPaused = false;
    });
  }

  void _resumePlayer() async {
    try {
      String playerStatus = await _flutterSound.resumePlayer();
      print('resumePlayer: $playerStatus');
      setState(() {
        _isPlaying = true;
        _isPaused = false;
      });
    } catch (error) {
      debugPrint('resumePlayer error :$error');
    }
  }

  void _pausePlayer() async {
    try {
      String playerStatus = await _flutterSound.pausePlayer();
      print('pausePlayer: $playerStatus');
      setState(() {
        _isPlaying = false;
        _isPaused = true;
      });
    } catch (error) {
      debugPrint('pausePlayer error :$error');
    }
  }

  void _stopPlayer() async {
    try {
      String playerStatus = await _flutterSound.stopPlayer();
      print('stopPlayer: $playerStatus');
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }
      setState(() {
        _isPlaying = false;
        _playerText = '00:00:00';
      });
    } catch (error) {
      debugPrint('stopPlayer error: $error');
    }
  }

  void _saveRecord() async {
    await _saveRecordedAudioPathPref(_recordedAudioPath).then(
      (SharedPreferences returnValue) {
        debugPrint(
          '[RecordAudioPage] ShPref saved: ${returnValue.getString('RecAudioPath')}',
        );
        widget.updateRecordedAudioPath();
        Navigator.pop(context);
      },
    );
  }

  void _deleteRecord() {
    Navigator.pop(context);
  }

  Future<void> _generateNewRecAudioPath() async {
    await _databaseHelper.initializeDatabase().then(
      (Database myDatabase) async {
        await _databaseHelper.getIdeasList().then(
          (List<Idea> myIdeasList) {
            debugPrint('${myIdeasList.length.toString()} ideas');
            setState(() {
              if (myIdeasList.isEmpty || myIdeasList == null) {
                _recordedAudioPath = 'sdcard/idea.mp4';
              } else {
                String newIndex = myIdeasList.length.toString();
                _recordedAudioPath = 'sdcard/idea$newIndex.mp4';
              }
            });
          },
        );
      },
    );
  }

  Future<SharedPreferences> _saveRecordedAudioPathPref(String path) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('RecAudioPath', path);
    return sharedPreferences;
  }
}
