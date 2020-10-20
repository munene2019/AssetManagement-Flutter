import 'dart:convert';

import 'package:flutter/cupertino.dart';


import 'httphelper.dart';

class ApisHelper {
  ApisHelper();
  final String url="http://8507895f3524.ngrok.io/assetsmanagement/auth";

  Future <Map<String, dynamic>> feedbackAPICaller(String jsonEquivalent) async {
    Map<String, dynamic> responseBack = {'code': 500, 'status': 1};
    var httphelper = HttpHelper();




    final response =await  httphelper.httpPOST(url, jsonEquivalent);
    
      var code = response['code'];
      var body = response['body'];

     
      responseBack['code'] = code;

      if (code == 200 && json.decode(body.toString())['status'] == 0) {
        responseBack['status'] = json.decode(body.toString())['status'];
      }
    

    return responseBack;
  }

  Future<Map<String, dynamic>> scansAPICaller(String jsonEquivalent) async {
    Map<String, dynamic> responseBack = {'code': 500, 'body': 'An Error Occured'};
    var httphelper = HttpHelper();

    final response =
        await httphelper.httpPOST(url, jsonEquivalent);
   
      responseBack['code'] = response['code'];
      responseBack['body'] = response['body'];
    

    return responseBack;
  }



  Future<Map<String, dynamic>> refillScansAPICaller(String jsonEquivalent) async {
    Map<String, dynamic> responseBack = {'code': 500, 'body': 'An Error Occured'};
    var httphelper = HttpHelper();

    final response =
        await httphelper.httpPOST(url, jsonEquivalent);
   
      responseBack['code'] = response['code'];
      responseBack['body'] = response['body'];
    

    return responseBack;
  }
}
