import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/api_client.dart';

class UserRepo extends GetxService{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
  Future<http.Response> SignUp(data,apiUrl) async{
    var fullApiUrl=apiClient.appBaseUrl+apiUrl;
    return await apiClient.SignUp(data, fullApiUrl);
  }
  Future<http.Response> SignIn(data,apiUrl) async{
    var fullApiUrl=apiClient.appBaseUrl+apiUrl;
    return await apiClient.SignIn(data, fullApiUrl);
  }
}