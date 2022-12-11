
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/api_client.dart';

class FoodDetailRepo extends GetxService {
  final ApiClient apiClient;
  FoodDetailRepo({required this.apiClient});

  Future<http.Response> getFoodDetail(id) async {
    var fullApiUrl ="${apiClient.appBaseUrl}api/Food/GetFoodViewMobile?FoodID="+id;

    return await apiClient.Get(fullApiUrl);
  }
}
