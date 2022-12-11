
import 'package:cdcn/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FoodOfStoreRepo extends GetxService {
  final ApiClient apiClient;
  FoodOfStoreRepo({required this.apiClient});

  Future<http.Response> getAllFoodOfStore(id, lat, lng) async {
    var fullApiUrl ="${apiClient.appBaseUrl+ "GetStore?storeId=" + id + "&lat=" + lat}lng=" +lng;


    return await apiClient.Get(fullApiUrl);
  }
  Future<http.Response> getAllCommentStore(id,index) async {
    var fullApiUrl ="${apiClient.appBaseUrl+ "GetReviews?index=$index"}&storeId=$id";
    return await apiClient.Get(fullApiUrl);
  }
}