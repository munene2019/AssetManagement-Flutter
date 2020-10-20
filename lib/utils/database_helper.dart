import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutternotekeeper/models/note1.dart';

class DatabaseHelper {
  DatabaseHelper._CreateInstance();

  static DatabaseHelper _databaseHelper;
  static Database _database;
  String noteTable = "note_table";
  String coId = "id";
  String coTitle = "title";
  String coDescription = "description";
  String coPriority = "priority";
  String coDate = "date";

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._CreateInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    //debugPrint(_database.toString());
    if (_database == null) {

      _database = await initializeDatabase();
      return _database;
    }
  }

  Future<Database> initializeDatabase() async {
    debugPrint("HERE DB1");
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($coId INTEGER PRIMARY KEY AUTOINCREMENT,$coTitle TEXT,$coDescription TEXT,$coPriority INTEGER,$coDate TEXT) ');
  }
  Future<List<Map<String,dynamic>>> getNoteMapList()async{

    Database db=await this.database;
    var result=await db.query(noteTable,orderBy:'$coPriority ASC' );
    return result;

  }
//  Future<int> insertNote(Note note)async{
//
//    Database db=await this.database;
//    debugPrint("mapppppp");
//    debugPrint(noteTable);
//
//    debugPrint(note.toMap().toString());
//    var result=await db.insert(noteTable, note.toMap());
//    debugPrint(result.toString());
//
//
//    return result;
//  }
//  Future<int>updateNote(Note note)async{
//    Database db=await this.database;
//    var result=await db.update(noteTable, note.toMap(),where: '$coId=?',whereArgs: [note.id]);
//
//    return result;
//  }
  Future<int> deleteNote(int id)async{
    Database db=await this.database;
    var result=await db.rawDelete('DELETE FROM $noteTable where: $coId=$id');

    return result;
  }
//  Future<int> getCount()async{
//
//    Database db=await this.database;
//    List<Map<String,dynamic>> x=await db.rawQuery('SELECT COUNT (*) from $noteTable');
//    int result=Sqflite.firstIntValue(x);
//    return result;
//
//  }
//  Future<List<Note>>getNoteList() async{
//    var nodeMapList=await getNoteMapList();
//    int count=nodeMapList.length;
//    List<Note>noteList=List<Note>();
//    for(int i=0;i<count;i++){
//      noteList.add(Note.fromObject(nodeMapList[i]));
//
//    }
//    return noteList;
//
//  }
}
