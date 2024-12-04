import 'package:http/http.dart';
import 'package:sampletest/helper/api_helper.dart';
import 'package:sampletest/helper/constants.dart';

class DashboardRepo{


  static Future<Response> getDashboardData()async{
    return await ApiHelper.getCall(AppConstants.dashboardEndPoint);
  }


}