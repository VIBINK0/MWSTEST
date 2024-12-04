import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiHelper{

   static const String baseUrl = 'https://makeup-api.herokuapp.com/';
  static Future<http.Response>  getCall(String endPoints)async{

    debugPrint('URl : ${baseUrl + endPoints}');

    final response = await http.get(Uri.parse(baseUrl + endPoints));

    debugPrint('RESPONSE : ${response.statusCode} ${baseUrl + endPoints}\n ${response.body}');

    return response;
  }

}