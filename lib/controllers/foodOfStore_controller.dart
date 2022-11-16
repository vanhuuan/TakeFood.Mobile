import 'dart:convert';
import 'package:get/get.dart';
import '../data/repository/foodOfStore_repo.dart';
import 'package:http/http.dart' as http;

import '../models/foodStore_model.dart';
class FoodOfStoreController extends GetxController{
  final FoodOfStoreRepo foodOfStoreRepo;
  FoodOfStoreController({required this.foodOfStoreRepo});
  dynamic _foodsStore;
  dynamic get foodsStore=>_foodsStore;
   List<dynamic> _foodOfStoreList=[];
   List<dynamic> get foodOfStoreList=>_foodOfStoreList;
  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;
  Future<bool> getAllFoodOfStore(id,lat,lng)async{
    http.Response response=(await foodOfStoreRepo.getAllFoodOfStore(id,lat,lng));
    if(response.statusCode==200){
      _foodsStore=null;
      _foodsStore=FoodStore.fromJson(jsonDecode(response.body));
      _foodOfStoreList=[];
      _foodOfStoreList.addAll(FoodStore.fromJson(jsonDecode(response.body)).foods);
      _isLoaded=true;
      update();
      return true;
    }else{
      return false;
    }
  }
}