import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutternotekeeper/models/note1.dart';
import 'package:flutternotekeeper/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import './login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'member_onboarding.dart';

class MainServices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainServicesState();
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage('assets/home.png');
    AssetImage paymentImage = AssetImage('assets/payments.png');
    AssetImage dollar = AssetImage('assets/dollar.png');
    void _nextScreen() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => memberOnboarding()));
    }
    return new ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: new Container(
            child: new Column(
              children: <Widget>[
               // Container(height: 40, color: Colors.transparent),
                Row(
                  children: <Widget>[
                    new Expanded(

                      child: new Container(
                          height: 200.0,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(100.0),
                            color: Colors.transparent,
                          ),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: <Widget>[
//                              FlatButton(onPressed: () {
//                                _nextScreen();
//                                print('mineeeeeeeeee');
//                              }),
                              FlatButton(
                                onPressed: () {
                                  _nextScreen();
                                  print('I got clicked');
                                },
                                child: Image.asset('assets/dollar.png',width: 80,
                                  height: 80,),
                              ),
//                              Image(
//
//                                image: dollar,
//                                width: 80.0,
//                                height: 80.0,
//                                // onPressed: () {},
//                              ),
                              Text(
                                "Asset Onboarding",
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                            //    children: <Widget>[new Icon(Icons.drive_eta)],
                          )),
                    ),
                    new Expanded(
                      child: new Container(
                          height: 100.0,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                    ),
                    new Expanded(
                      child: new Container(
                          height: 200.0,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(100.0),
                            color: Colors.transparent,
                          ),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  _nextScreen();
                                  print('I got clicked');
                                },
                                child: Image.asset('assets/dollar.png',width: 80,
                                  height: 80,),
                              ),
//                              Image(
//                                image: paymentImage,
//                                width: 80.0,
//                                height: 80.0,
//                              ),
                              Text(
                                "Asset Linking",
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),
                Container(height: 40, color: Colors.transparent),
                Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                          height: 200.0,
                          width: 200.0,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(100.0),
                            color: Colors.transparent,
                          ),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  _nextScreen();
                                  print('I got clicked');
                                },
                                child: Image.asset('assets/dollar.png',width: 100,
                                    height: 100),
                              ),
                              Text(
                                "Staff Onboarding",
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                            //    children: <Widget>[new Icon(Icons.drive_eta)],
                          )),
                    ),
                    new Expanded(
                      child: new Container(
                          height: 100.0,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                    ),
                    new Expanded(
                      child: new Container(
                          height: 200.0,
                          width: 200,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(200.0),
                            color: Colors.transparent,
                          ),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  _nextScreen();
                                  print('I got clicked');
                                },
                                child: Image.asset('assets/dollar.png',width: 100,
                                    height: 100),
                              ),
                              Text("Asset Allocation",
                                  style: new TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  )),
                            ],
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class MainServicesState extends State<MainServices> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  // List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Asset Management", textAlign: TextAlign.right),
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.deepPurple),
      ),
      body: MainContent(),
    );
    // TODO: implement build
  }



  ListView getNoteListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
//          return Card(
//            color: Colors.white,
//            elevation: 2.0,
//            child: ListTile(
//              leading: CircleAvatar(
//                backgroundColor:
//                //    getPriorityColor(this.noteList[position].priority),
//               // child: getPriorityIcon(this.noteList[position].priority),
//              ),
//            //  title: Text(this.noteList[position].title, style: textStyle),
//            //  subtitle: Text(this.noteList[position].date),
//              trailing: GestureDetector(
//                child: Icon(
//                  Icons.delete,
//                  color: Colors.grey,
//                ),
//                onTap: () {
//                //  _delete(context, this.noteList[position]);
//                },
//              ),
//              onTap: () {
//                debugPrint("List Title Tapped");
//              //  NavigateToDetail(this.noteList[position], 'Edit Note');
//              },
//            ),
//          );
        });
  }

//  void NavigateToDetail(Note note, String title) async {
//    bool result =
//        await Navigator.push(context, MaterialPageRoute(builder: (context) {
//      return NoteDetail(note, title);
//    }));
//    if (result == true) {
//     // updateListView();
//    }
//  }

//  Color getPriorityColor(int priority) {
//    switch (priority) {
//      case 1:
//        return Colors.red;
//      case 2:
//        return Colors.yellow;
//      default:
//        return Colors.yellow;
//    }
//  }

//  Icon getPriorityIcon(int priority) {
//    switch (priority) {
//      case 1:
//        return Icon(Icons.play_arrow);
//      case 2:
//        return Icon(Icons.keyboard_arrow_right);
//      default:
//        return Icon(Icons.keyboard_arrow_right);
//    }
//  }

//  void _delete(BuildContext context, Note note) async {
//    int result = await databaseHelper.deleteNote(note.id);
//    if (result != 0) {
//      _ShowSnackBar(context, 'Note deleted successfully');
//      updateListView();
//    }
//  }

//  void _ShowSnackBar(BuildContext context, String message) {
//    var snackBar = SnackBar(content: Text(message));
//    Scaffold.of(context).showSnackBar(snackBar);
//  }

//  void updateListView() {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
//      noteListFuture.then((noteList) {
//        setState(() {
//          this.noteList = noteList;
//          this.count = noteList.length;
//        });
//      });
//    });
//  }
}
