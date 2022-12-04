
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/api_client.dart';

class RecommendedStoreNearRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedStoreNearRepo({required this.apiClient});
  Future<http.Response> getRecommendedStoreNearList(data) async{
    var fullApiUrl="${apiClient.appBaseUrl}GetNearBy";
    print(fullApiUrl);
    return await apiClient.getStoreNear(data,fullApiUrl);
  }

}