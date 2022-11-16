
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/api_client.dart';

class FoodOfStoreRepo extends GetxService {
  final ApiClient apiClient;
  FoodOfStoreRepo({required this.apiClient});

  Future<http.Response> getAllFoodOfStore(id, lat, lng) async {
    var fullApiUrl =
        "${"https://takefoodstoreservice.azurewebsites.net/GetStore?storeId=" + id + "&lat=" + lat}&lng=" +
            lng;

    return await apiClient.Get(fullApiUrl);
  }
}
