import 'package:flutter/material.dart';
import './app_screens/mainServices.dart';
import './app_screens/login.dart';
import './models/note1.dart';

void main(){
runApp(
    MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      title: "Asset Management",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:Colors.deepPurple,
      ),
      home:user_login('Asset Management'),

    );

  }

}
