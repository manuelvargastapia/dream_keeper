class Idea {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;
  String _problemToSolve;
  String _customerSegment;
  String _valueProposition;
  String _recAudioPath;

  Idea(
    this._title,
    this._date, [
    this._priority = 2,
    this._description,
    this._problemToSolve,
    this._customerSegment,
    this._valueProposition,
    this._recAudioPath,
  ]);

  Idea.withId(this._id, this._title, this._date, this._priority,
      [this._description,
      this._problemToSolve,
      this._customerSegment,
      this._valueProposition,
      this._recAudioPath]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;
  String get problemToSolve => _problemToSolve;
  String get customerSegment => _customerSegment;
  String get valueProposition => _valueProposition;
  String get recAudioPath => _recAudioPath;

  set title(String title) {
    if (title.length <= 255) {
      this._title = title;
    }
  }

  set description(String description) {
    if (description.length <= 255) {
      this._description = description;
    }
  }

  set priority(int priority) {
    if (priority >= 1 && priority <= 2) {
      this._priority = priority;
    }
  }

  set date(String date) {
    this._date = date;
  }

  set problemToSolve(String problemToSolve) {
    if (problemToSolve.length <= 255) {
      this._problemToSolve = problemToSolve;
    }
  }

  set customerSegment(String customerSegment) {
    if (customerSegment.length <= 255) {
      this._customerSegment = customerSegment;
    }
  }

  set valueProposition(String valueProposition) {
    if (valueProposition.length <= 255) {
      this._valueProposition = valueProposition;
    }
  }

  set recAudioPath(String recAudioPath) {
    this._recAudioPath = recAudioPath;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    map['problemToSolve'] = _problemToSolve;
    map['customerSegment'] = _customerSegment;
    map['valueProposition'] = _valueProposition;
    map['recAudioPath'] = _recAudioPath;

    return map;
  }

  Idea.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
    this._problemToSolve = map['problemToSolve'];
    this._customerSegment = map['customerSegment'];
    this._valueProposition = map['valueProposition'];
    this._recAudioPath = map['recAudioPath'];
  }
}
