import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/idea.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String ideaTable = 'idea_table';
  String columnId = 'id';
  String columnTitle = 'title';
  String columnDate = 'date';
  String columnBrainstorm = 'brainstorm';
  String columnProblem = 'problem';
  String columnSolution = 'solution';
  String columnCustomers = 'customers';
  String columnChannels = 'channels';
  String columnActivities = 'activities';
  String columnUniqueValue = 'uniqueValue';
  String columnCosts = 'costs';
  String columnRevenues = 'revenues';
  String columnRecAudioPath = 'recAudioPath';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = directory.path + 'dreamkeeper.db';
    var myDatabase = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createTables,
    );
    return myDatabase;
  }

  void _createTables(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $ideaTable('
          '$columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnTitle TEXT, '
          '$columnDate TEXT, $columnBrainstorm TEXT, '
          '$columnProblem TEXT, $columnSolution TEXT, '
          '$columnCustomers TEXT, $columnChannels TEXT, '
          '$columnActivities TEXT, $columnUniqueValue TEXT, '
          '$columnCosts TEXT, $columnRevenues TEXT, '
          '$columnRecAudioPath TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getIdeasMapList() async {
    Database myDatabase = await this.database;
    var result = await myDatabase.query(
      ideaTable,
      orderBy: '$columnTitle ASC',
    );
    return result;
  }

  Future<int> insertIdea(Idea idea) async {
    Database myDatabase = await this.database;
    var result = await myDatabase.insert(ideaTable, idea.toMap());
    return result;
  }

  Future<int> updateIdea(Idea idea) async {
    Database myDatabase = await this.database;
    var result = await myDatabase.update(
      ideaTable,
      idea.toMap(),
      where: '$columnId = ?',
      whereArgs: [idea.id],
    );
    return result;
  }

  Future<int> deleteIdea(int ideaID) async {
    Database myDatabase = await this.database;
    int result = await myDatabase.rawDelete(
      'DELETE FROM $ideaTable WHERE $columnId = $ideaID',
    );
    return result;
  }

  Future<int> getIdeasCount() async {
    Database myDatabase = await this.database;
    List<Map<String, dynamic>> ideasList = await myDatabase.rawQuery(
      'SELECT COUNT (*) from $ideaTable',
    );
    int result = Sqflite.firstIntValue(ideasList);
    return result;
  }

  Future<List<Idea>> getIdeasList() async {
    var ideasMapList = await getIdeasMapList();
    int count = ideasMapList.length;
    List<Idea> ideasList = List<Idea>();
    for (int i = 0; i < count; i++) {
      ideasList.add(Idea.fromMapObject(ideasMapList[i]));
    }

    return ideasList;
  }
}
