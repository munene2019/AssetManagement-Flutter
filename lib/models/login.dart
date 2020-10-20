import 'dart:convert';

class Login {
  String _username;
  String _Request;
  String _password;


  Login();


  String get username => _username;
  String get Request => _Request;
  String get password => _password;


  set username(String value) {
    _username = value;
  }
  set request(String value) {
    _Request = value;
  }


  set password(String value) {
    _password = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['username'] = _username;
    map['password'] = _password;
    return map;
  }

  //Extract a Feedback object from a map object
  Login.fromMapObject(Map<String, dynamic> map) {
    this._username = map['username'];
    this._password = map['password'];
  }

  String toJson(Map<String, dynamic> map) {
    return jsonEncode(map);
  }
}