import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
import '../api/api_client.dart';

class UserRepo extends GetxService{
  final ApiClient apiClient;
  var user;
  String address="";
  UserRepo({required this.apiClient});
  Future<http.Response> SignUp(data,apiUrl) async{
    var fullApiUrl=apiClient.appBaseUrl+apiUrl;
    return await apiClient.SignUp(data, fullApiUrl);
  }
  Future<http.Response> SignIn(data,apiUrl) async{
    var fullApiUrl=apiClient.appBaseUrl+apiUrl;
    return await apiClient.SignIn(data, fullApiUrl);
  }
  Future<bool> LogOut(){
    return apiClient.LogOut();
  }
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getuser;
    if(prefs.containsKey("user")){
      getuser=prefs.getString("user");
      user=User.fromJson(jsonDecode(getuser!));
    }
    var fullApiUrl ="${apiClient.appBaseUrl}GetAddress";
    http.Response response=await apiClient.Get(fullApiUrl);
    if(response.statusCode==200){
      address="";
      var data=jsonDecode(response.body);
      address=data.toString()=="[]"? "Chưa có địa chỉ":data.last['address'];
      print("address$address");
      prefs.setString("address", address);
    }else{
      print(response.statusCode);
    }
    return user;
  }
  Future<bool> editProfile(data, address) async {
    var fullApiUrlUpdateInfo ="${apiClient.appBaseUrl}UpdateInfo";
    var fullApiUrlAddress ="${apiClient.appBaseUrl}AddAddress";
    http.Response response=await apiClient.PutData(fullApiUrlUpdateInfo, data);
    http.Response res=await apiClient.postOrder(fullApiUrlAddress, address);
    if(response.statusCode==200 && res.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
}