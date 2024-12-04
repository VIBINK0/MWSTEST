import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sampletest/data/models/dashboard_model.dart';
import 'package:sampletest/data/repos/dashboard_repo.dart';

class DashboardViewModel{


  static Future<List<DashboardModel>?> getDashboardData() async{

    try {
      final response = await DashboardRepo.getDashboardData();

      if(_isValidData(response)){
        final jsonStr = jsonDecode(response.body);
        Iterable list  = jsonStr;
        List<DashboardModel> dashboardModel = list.map((e) => DashboardModel.fromJson(e)).toList();
        return dashboardModel;
      }else{
        return null;
      }
    } catch (e) {
      debugPrint("DASHBOARD ERROR : $e");
      return null;
    }

  }

 static bool _isValidData(Response response) => response.statusCode == 200;

}