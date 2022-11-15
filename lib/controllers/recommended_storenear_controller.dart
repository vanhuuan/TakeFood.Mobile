import 'dart:convert';

import 'package:get/get.dart';
import '../data/repository/recommended_storenear_repo.dart';
import 'package:http/http.dart' as http;

import '../models/store_model.dart';
class RecommendedStoreNearController extends GetxController{
  final RecommendedStoreNearRepo recommendedStoreNearRepo;
  RecommendedStoreNearController({required this.recommendedStoreNearRepo});
  List<dynamic> _storeNearList=[];
  List<dynamic> get storeNearList=>_storeNearList;
  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;
  Future<void> getRecommendedStoreNearList(data)async{

    http.Response response=(await recommendedStoreNearRepo.getRecommendedStoreNearList(data));
    print("popular");
    print(response.statusCode);
    if(response.statusCode==200){
      _storeNearList=[];
      List<dynamic>  decodedList = json.decode(response.body);
      List<Store> posts = List<Store>.from(decodedList.map((model)=> Store.fromJson(model)));
     _storeNearList.addAll(posts);
     print(_storeNearList);
     _isLoaded=true;
      update();
    }else{
      print("sai");
    }
  }
}