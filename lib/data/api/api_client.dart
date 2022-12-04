import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class ApiClient extends GetConnect implements GetxService {
  final String  appBaseUrl;
  Map<String, String> cookies = {};
  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
  }
  Future<http.Response>  Get(String uri) async {
    print(uri);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token=prefs?.getString("token");
    print(token);
    http.Response response=await http.get(
        Uri.parse(uri),
        headers: _mainHeaders(token)
    );
    print("Get${response.statusCode}");
    return response;
  }
  Future<http.Response> PutData(String uri, data) async {
    print(uri);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token=prefs?.getString("token");
    http.Response response=await http.put(
        Uri.parse(uri),
        body: jsonEncode(data),
        headers: _mainHeaders(token)
    );
    print("putdata${response.statusCode}");
    return response;
  }
  Future<http.Response> postOrder(String apiUrl,order) async {
    print(apiUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token=prefs?.getString("token");

    http.Response response=await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(order),
        headers: _mainHeaders(token)
    );
    print("postOrder${response.statusCode}");
    return response;
  }
  Future<http.Response> SignUp(data,apiUrl) async{
    print(apiUrl);
    http.Response response= await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    return response;

  }
  Future<http.Response> SignIn(data,apiUrl) async{
    print(apiUrl);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response= await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    print("SignIn${response.statusCode}");
    return response;
  }
  Future<bool> LogOut() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
      await prefs.remove("user");
      await prefs.remove("address");
      await prefs.remove("nameUser");
      return true;
    }
    catch(e){
      return false;
    }
  }
  Future<http.Response> getStoreNear(data,apiUrl) async{
    print(apiUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token=prefs.getString("token");
    http.Response response= await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: _mainHeaders(token),
    );
    print("huhu");
    print(response.statusCode);
    if(response.statusCode==401){
      var refreshToken="https://takefoodauthentication.azurewebsites.net/GetAccessToken?token=${prefs.getString("refreshToken")!}";
      print(refreshToken);
      http.Response res=await http.get(
          Uri.parse(refreshToken),
          headers: _setHeaders()
      );
      print("token"+res.statusCode.toString());
      if(res.statusCode==200){
        User user=User.fromJson(jsonDecode(res.body));
        await prefs.setString("token", user.accessToken!);
      }
      http.Response response= await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(data),
        headers: _mainHeaders(prefs.getString("token")),
      );
      print(response.statusCode);
      return response;
    }
    return response;
  }
  _setHeaders()=>{
    'Content-type': 'application/json',
    'Accept':'application/json'
  };
  _mainHeaders (token)=> {
    'Content-type': 'application/json',
    'Accept':'application/json',
    'Authorization': 'Bearer $token',
  };

  Response handleResponse(Response response) {
    Response _response = response;
    if(_response.hasError && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: "Error");

      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);

      }
    }else if(_response.hasError && _response.body == null) {
      print("The status code is "+_response.statusCode.toString());
      _response = Response(statusCode: 0, statusText: 'Connection to API server failed due to internet connection');
    }
    return _response;
  }
}