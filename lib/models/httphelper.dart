import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  //Creating a singletone
  static HttpHelper _instance;
  HttpHelper._internal();

  factory HttpHelper() {
    if (_instance == null) {
      _instance = HttpHelper._internal();
    }
    return _instance;
  }

  Future<Map<String, dynamic>> httpPOST(String url, String body,
      {Map<String, String> headers}) async {
    var map = Map<String, dynamic>();
    try {
      debugPrint(url);
      debugPrint(body);
      var response = await http.post(url, body: body, headers: headers);
      map['code'] = response.statusCode;
      map['body'] = response.body;
    }catch(e){
      map['code'] = 500;
      map['body'] = 'Could not connect to server'+e.toString();
      debugPrint("Exception----------------------------------------------------------------------");
      debugPrint(e.toString());
    }
    return map;
  }


  Future<Map<String, dynamic>> httpGET(String url,
      {Map<String, String> headers}) async {
    var map = Map<String, dynamic>();
    try {
      var response = await http.get(url, headers: headers);
      map['code'] = response.statusCode;
      map['body'] = response.body;
    }catch(e){
      map['code'] = 500;
      map['body'] = 'Could not connect to server';

    }
    return map;
  }
}
