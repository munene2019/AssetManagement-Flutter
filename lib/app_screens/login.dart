import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutternotekeeper/models/dialogs.dart';
import 'package:flutternotekeeper/models/note1.dart';
import 'package:flutternotekeeper/utils/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutternotekeeper/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutternotekeeper/models/login.dart';
import 'package:flutternotekeeper/utils/httphelper.dart';
import 'package:flutternotekeeper/utils/apishelper.dart';
import 'package:flutternotekeeper/app_screens/mainServices.dart';

class user_login extends StatefulWidget {
  final appBarTitle;

  // final Note note;

  user_login(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return user_loginState(this.appBarTitle);
  }
}

class user_loginState extends State<user_login> {
  final Login login = new Login();

  var _formKey = GlobalKey<FormState>();
  UserModel _user;
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Note note;
  static var _priorities = ['High', 'Low'];
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  user_loginState(this.appBarTitle);

  //API CALLING
  var stateList;
  var data;
  String _mySelection;

  //var ;
  List _myState; //edited line
  String stateUrl = "http://192.168.100.2/Backend/users/login.php";
  String javaUrl="http://192.168.100.2:7001/ChannelServiceAdapter/Request";

  Future<String> getStateList() async {
    var body = jsonEncode({"Request": "countries"});

    print("Body: " + body);
    http
        .post(stateUrl,
            headers: {"Content-Type": "application/json"}, body: body)
        .then((http.Response response) {
      print("Response status: ${response.body}");
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
      var resBody = json.decode(response.body);
      setState(() {
        _myState = resBody['cities'];
      });
    });
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    getStateList();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    ;
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          MoveToLastScreen();
        },
        child: Scaffold(
            appBar: AppBar(
              // title: Text("Asset Management"),
              title: Text("Asset Management", textAlign: TextAlign.right),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.0, top: 150.0),
                child: ListView(
                  children: <Widget>[
                    //First Element
//                    ListTile(
//                      title: DropdownButton(
//                          items: _priorities.map((String dropDownStringItem) {
//                            return DropdownMenuItem<String>(
//                              value: dropDownStringItem,
//                              child: DropdownButton(
//                                value: _myState,
//                                hint: Text('Select Name'),
//                                items: stateList.map((list) {
//                                  return DropdownMenuItem(child: Text(list['NAME']),
//                                  value: list['CODE'].toString());
//
//                                }),
//                                onChanged: (value){
//                                  setState(() {
//                                    _myState=value;
//
//                                  });
//
//                                },
//                              ),
//                            ).toList();
//                          }).toList(),
//                          style: textStyle,
//                          value: getPriorityAsString(note.priority),
//                          onChanged: (valueSelectedByUser) {
//                            setState(() {
//                              debugPrint("User selected $valueSelectedByUser");
//                              updatePriorityAsInt(valueSelectedByUser);
//                            });
//                          }
//                          ),
//                      //2nd Element
//                    ),
                    //2nd Element

                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: usernameController,
                        validator: (String val) {
                          if (val.isEmpty) {
                            return 'Please enter username';
                          }
                        },
                        style: textStyle,
                        onChanged: (value) {
                          debugPrint("Something happened in this field");
                          updateUsername();
                        },
                        decoration: InputDecoration(
                            labelText: "Username",
                            hintText: "Enter username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            errorStyle: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    //Third Element
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (String val) {
                          if (val.isEmpty) {
                            return 'Please enter password';
                          }
                        },
                        style: textStyle,
                        onChanged: (value) {
                          debugPrint("Something happened in this field");

                          updatePassword();
                        },
                        decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            errorStyle: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.all(20.0),

                      // hack textfield height
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 25.0, left: 25.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                              child: Expanded(
                                  child: ButtonTheme(
                            height: 65,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.purple)),
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text(
                                  'Login',
                                  textScaleFactor: 1.5,
                                ),
                                onPressed: () async {
                                  final action = await Dialogs.yesAbortDialog(
                                      context,
                                      'My title',
                                      'Do You want to login?');
                                  if (action == DialogAction.yes) {
                                    String username = usernameController.text;
                                    String password = passwordController.text;
                                   // login_java();
                                    login_User(username, password);
                                  } else {


                                  }
                                  setState(() {
                                    debugPrint("Save button Clicked");
                                    // _save();
//                                    MaterialPageRoute(
//                                        builder: (context) => MainServices());
                                    //  _submitFeedback(context);
                                  });
                                }),
                          )))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  MoveToLastScreen() {
    Navigator.pop(context, true);
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

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;

      default:
    }
  }

  void updatePassword() {
    login.password = passwordController.text;
  }

  void updateUsername() {
    login.username = usernameController.text;
  }
  Future<String> login_java() async {
    var body = jsonEncode(
        {"Name": "Rogers", "Account": "1223333", "CorrelationID": "73737373"});
    var res;

    print("Body: " + body);
    http
        .post(javaUrl,
        headers: {"Content-Type": "application/json"}, body: body)
        .then((http.Response response) {
      print("Response status: ${response.body}");
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
      var resBody = json.decode(response.body);
      print("nene122");
      print(resBody);
     var name = resBody['Name'];
      var account = resBody['Account'];
      print(name);
      print(account);
      setState(() async {
//        _myState = resBody['Name'];
//        print(resBody);
        print(_myState);
        Map sent = _myState.asMap();
      //  var res = sent['USERNAME'];
        print("nene122");
        print(sent);
        print("nene");
       var status ;
        print("NDANI");
        if (status == '404') {
          print("NDANI2");
          final action = await Dialogs.yesAbortDialog(
              context, 'My title', 'user does not exist');
          // return status;
          //Dialogs.yesAbortDialog(context, 'My title', 'User does not exist');
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainServices()));
         // print(sent[0]['STATUS']);
          //print(sent[0]['USERNAME']);
          // _myState['Password'];
        //  print(sent[0]['USERNAME']);
        }
      });
    });
    return "Sucess";
  }
  Future<String> login_User(username, password) async {
    var body = jsonEncode(
        {"Request": "login", "username": username, "password": password});
    var res;

    print("Body: " + body);
    http
        .post(stateUrl,
            headers: {"Content-Type": "application/json"}, body: body)
        .then((http.Response response) {
      print("Response status: ${response.body}");
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
      var resBody = json.decode(response.body);
      setState(() async {
        _myState = resBody['users'];
        Map sent = _myState.asMap();
        var res = sent['USERNAME'];
        print("nene122");
        print(sent);
        print("nene");
        var status = sent[0]['STATUS'];
        print("NDANI");
        if (status == '404') {
          print("NDANI2");
          final action = await Dialogs.yesAbortDialog(
              context, 'My title', 'user does not exist');
          // return status;
          //Dialogs.yesAbortDialog(context, 'My title', 'User does not exist');
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainServices()));
          print(sent[0]['STATUS']);
          print(sent[0]['USERNAME']);
          // _myState['Password'];
          print(sent[0]['USERNAME']);
        }
      });
    });
    return "Sucess";
  }

  void _submitFeedback(BuildContext cont) async {
    // _getStateList();
    // var feedbackhelper = new FeedbackHelper();
    var apisHelper = new ApisHelper();

    Map<String, dynamic> mapEquivalent = login.toMap();

    //Record entry in database
    //int recorded = await feedbackhelper.recordFeedback(mapEquivalent);

    if (_formKey.currentState.validate()) {
      String jsonEquivalent = login.toJson(mapEquivalent);

      Map<String, dynamic> sent =
          await apisHelper.feedbackAPICaller(jsonEquivalent);
      debugPrint("codee");

      int code = sent['code'];
      int message = sent['message'];
      debugPrint(message.toString());
      int state = 1; //Success
      if (code == 200 && sent['status'] == 0) {
        alertDialog('status', 'Login successful');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainServices()));
      } else {
        if (code != 200) {
          state = 2; //Failed - Network issue, retry latter
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainServices()));
          alertDialog('status',
              'Connection to server failed, synchronisation will be done later');
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainServices()));
          alertDialog('status', 'Feedback could not be submited');
        }
      }
    }
    // feedbackhelper.updateFeedback(recorded, state);

    // List rs = await Databasehelper().selectList('feedbacks');
    //debugPrint(rs.toString());
  }

  void _save() async {
    String email = usernameController.text;
    String name = passwordController.text;

    // MoveToLastScreen();
    final UserModel user = await createUser(name, email);
    setState(() {
      if (_formKey.currentState.validate()) {
        _user = user;
      }
    });
    alertDialog('status',
        'The user ${_user.name} was succesfully created and ${_user.createdAt}');
    note.date = DateFormat.yMMMd().format(DateTime.now());
    // note.id=1;
    debugPrint("User selected $note.date");
    int result;

    if (note.id != null) {
      // result = await helper.updateNote(note);
    } else {
      // result = await helper.insertNote(note);
    }
    if (result != 0) {
      alertDialog('status', 'Note saved successfully');
    } else {
      alertDialog('status', 'Problem saving Note');
    }
  }

  void _delete() async {
    MoveToLastScreen();
    if (note.id == null) {
      alertDialog('status', 'No note was deleted');
      return;
    }
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      alertDialog('status', 'Note deleted successfully');
    } else {
      alertDialog('status', 'Error occurred while deleting Note');
    }
  }

  Future<UserModel> createUser(String name, String email) async {
    final String url = "https://reqres.in/api/users";
    final response = await http.post(url, body: {"name": name, "job": email});
    if (response.statusCode == 201) {
      final String responseString = response.body;
      return userModelFromJson(responseString);
    } else {
      return null;
    }
  }

  void alertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
