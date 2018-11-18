class Idea {
  int _id;
  String _title;
  String _date;
  String _brainstorm;
  String _problem;
  String _solution;
  String _customers;
  String _channels;
  String _activities;
  String _uniqueValue;
  String _costs;
  String _revenues;
  String _recAudioPath;

  Idea(
    this._title,
    this._date, [
    this._brainstorm,
    this._problem,
    this._solution,
    this._customers,
    this._channels,
    this._activities,
    this._uniqueValue,
    this._costs,
    this._revenues,
    this._recAudioPath,
  ]);

  Idea.withId(
    this._id,
    this._title,
    this._date, [
    this._brainstorm,
    this._problem,
    this._solution,
    this._customers,
    this._channels,
    this._activities,
    this._uniqueValue,
    this._costs,
    this._revenues,
    this._recAudioPath,
  ]);

  int get id => _id;
  String get title => _title;
  String get date => _date;
  String get brainstorm => _brainstorm;
  String get problem => _problem;
  String get solution => _solution;
  String get customers => _customers;
  String get channels => _channels;
  String get activities => _activities;
  String get uniqueValue => _uniqueValue;
  String get costs => _costs;
  String get revenues => _revenues;
  String get recAudioPath => _recAudioPath;

  set title(String title) {
    if (title.length <= 255) {
      this._title = title;
    }
  }

  set date(String date) {
    this._date = date;
  }

  set brainstorm(String brainstorm) {
    if (brainstorm.length <= 255) {
      this._brainstorm = brainstorm;
    }
  }

  set problem(String problem) {
    if (problem.length <= 255) {
      this._problem = problem;
    }
  }

  set solution(String solution) {
    if (solution.length <= 255) {
      this._solution = solution;
    }
  }

  set customers(String customers) {
    if (customers.length <= 255) {
      this._customers = customers;
    }
  }

  set channels(String channels) {
    if (channels.length <= 255) {
      this._channels = channels;
    }
  }

  set activities(String activities) {
    if (activities.length <= 255) {
      this._activities = activities;
    }
  }

  set uniqueValue(String uniqueValue) {
    if (uniqueValue.length <= 255) {
      this._uniqueValue = uniqueValue;
    }
  }

  set costs(String costs) {
    if (costs.length <= 255) {
      this._costs = costs;
    }
  }

  set revenues(String revenues) {
    if (revenues.length <= 255) {
      this._revenues = revenues;
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
    map['date'] = _date;
    map['brainstorm'] = _brainstorm;
    map['problem'] = _problem;
    map['solution'] = _solution;
    map['customers'] = _customers;
    map['channels'] = _channels;
    map['activities'] = _activities;
    map['uniqueValue'] = _uniqueValue;
    map['costs'] = _costs;
    map['revenues'] = _revenues;
    map['recAudioPath'] = _recAudioPath;

    return map;
  }

  Idea.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._date = map['date'];
    this._brainstorm = map['brainstorm'];
    this._problem = map['problem'];
    this._solution = map['solution'];
    this._customers = map['customers'];
    this._channels = map['channels'];
    this._activities = map['activities'];
    this._uniqueValue = map['uniqueValue'];
    this._costs = map['costs'];
    this._revenues = map['revenues'];
    this._recAudioPath = map['recAudioPath'];
  }
}
