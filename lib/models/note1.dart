import 'package:flutter/cupertino.dart';

class Note {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Note(this._title, this._date, this._priority, [this._description]);

 // Note.withId(this._id, this._title, this._date,this._priority,
     // [this._description]);

  int get id => _id;

  String get title => _title;

  int get priority => _priority;

  String get date => _date;

  String get description => _description;

  set id(int newid) {

    this._id = newid;
    debugPrint("priority");
    debugPrint(this._id .toString());
  }

  set description(String newdescription) {
    if (description.length <= 255) {
      this._description = newdescription;
    }
  }

  set priority(int newpriority) {
    if (newpriority >= 1 && newpriority <= 2) {
      this._priority = newpriority;
    }
    this._priority = newpriority;

  }

  set title(String newtitle) {
    if (newtitle.length <= 255) {
      this._title = newtitle;
    }
  }

  set date(String date) {
    if (date.length <= 255) {
      this._date = date;
    }
  }

//  Map<String, dynamic> toMap() {
//    var map = Map<String, dynamic>();
//    if (id != null) {
//      map['id'] = _id;
//    }
//    map['id'] = _id;
//    map['priority'] = _priority;
//    map['date'] = _date;
//    map['description'] = _description;
//    map['title'] = _title;
//    return map;
//  }

  Note.fromObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._description = map['description'];
    this._title = map['title'];
    this._date = map['date'];
    this._priority = map['priority'];
  }
}
