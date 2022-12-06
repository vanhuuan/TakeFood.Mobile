import 'dart:convert';
import 'package:cdcn/models/review_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/detailOrdered_model.dart';
import '../../models/myOrdered_model.dart';
import '../api/api_client.dart';

class MyOrderedRepo extends GetxService{
  final ApiClient apiClient;
  MyOrderedRepo({required this.apiClient});
  dynamic detailOrdered;
  List<Food>? listFood=[];
  List<Toppings> listTopping=[];
  Future<List<MyOrdered>> getMyOrdered(i) async {
    List<MyOrdered> listOrdered=[];
      var fullApiUrl ="${apiClient.appBaseUrl}GetOrders?index=$i";
      http.Response response=await apiClient.Get(fullApiUrl);
      if(response.statusCode==200){
        List<dynamic>  decodedList = json.decode(response.body);
        List<MyOrdered> posts = List<MyOrdered>.from(decodedList.map((model)=> MyOrdered.fromJson(model)));
        listOrdered.addAll(posts);
      }else{
        print(response.statusCode);
        print("SAI");
      }
      return listOrdered;
    }
    Future<http.Response> getDetailOrdered(orderedId) async {
      var fullApiUrl ="${apiClient.appBaseUrl}GetOrderdetail?orderId=$orderedId";
      http.Response response=await apiClient.Get(fullApiUrl);
      return response;
    }
    Future<Review?> getReviewByOrderId(orderId) async {
    var fullApiUrl="${apiClient.appBaseUrl}GetReview?orderId="+orderId;
    http.Response response=await apiClient.Get(fullApiUrl);
    if(response.statusCode==200){
      Review review=Review.fromJson(jsonDecode(response.body));
      return review;
    }
    return null;
    }
    Future<bool> revieworder(data) async {
       print(jsonEncode(data));
      var fullApiUrl ="${apiClient.appBaseUrl}CreateReview";
      http.Response response=await apiClient.postOrder(fullApiUrl, data);
      print(response.statusCode);
      if(response.statusCode==200){
        return true;
      }else{
        return false;
      }
    }

  }

