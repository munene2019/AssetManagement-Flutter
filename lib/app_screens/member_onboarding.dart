

import 'package:flutter/material.dart';
import 'dart:convert';
import 'mainServices.dart';
import 'package:http/http.dart' as http;

class memberOnboarding extends StatefulWidget {
  @override
  _memberOnboardingState createState() => _memberOnboardingState();
}

class _memberOnboardingState extends State<memberOnboarding> {
  var _formKey = GlobalKey<FormState>();
  var stateList;
  var data;
  String _mySelection;

  //var ;
  List _myState; //edited line
  String stateUrl = "http://192.168.100.2/Backend/users/login.php";

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
  void initState() {
    super.initState();
    getStateList();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
       // MoveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Member Onboarding",textAlign: TextAlign.center),

        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.0, top: 150.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    // controller: usernameController,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return 'Please enter Name';
                      }
                    },
                    //style: textStyle,
                    onChanged: (value) {
                      debugPrint("Something happened in this field");
                      //updateUsername();
                    },
                    decoration: InputDecoration(
                        labelText: "First Name",
                        hintText: "Enter First Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        errorStyle: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                   // controller: usernameController,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return 'Please enter username';
                      }
                    },
                    //style: textStyle,
                    onChanged: (value) {
                      debugPrint("Something happened in this field");
                      //updateUsername();
                    },
                    decoration: InputDecoration(
                        labelText: "Last Name",
                        hintText: "Enter Last Name",
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
                   // controller: passwordController,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return 'Please enter password';
                      }
                    },
                   // style: textStyle,
                    onChanged: (value) {
                      debugPrint("Something happened in this field");

                    //  updatePassword();
                    },
                    decoration: InputDecoration(
                        labelText: "National ID",
                        hintText: "Enter National ID",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        errorStyle: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: DropdownButton(
                    hint: Text('Select Country Name'),
                    items: _myState.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['NAME']),
                        value: item['CODE'].toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        getStateList();
                        _mySelection = newVal;
                        print(_mySelection);
                      });
                    },
                    value: _mySelection,
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
                                      'Submit',
                                      textScaleFactor: 1.5,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        debugPrint("Save button Clicked");
                                        // _save();
                                        MaterialPageRoute(
                                            builder: (context) => MainServices());
                                        //_submitFeedback(context);
                                      });
                                    }),
                              )))
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
