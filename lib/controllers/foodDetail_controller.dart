import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/foodDetail_repo.dart';
import '../models/cart_model.dart';
import '../models/food_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class FoodDetailController extends GetxController {
  final FoodDetailRepo foodDetailRepo;
  final SharedPreferences sharedPreferences;
  FoodDetailController({required this.foodDetailRepo,required this.sharedPreferences});
  dynamic _foodsDetail;
  dynamic get foodsDetail => _foodsDetail;
  List<dynamic> _toppingFood = [];
  List<dynamic> get toppingFood => _toppingFood;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 1;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems+_quantity;
  late List<ListTopping> _listTopping;
  List<ListTopping> get listTopping=>_listTopping;
  int? totalMoney=0;
  late CartController _cart;


  Future<bool> getFoodDetailById(id) async {
    http.Response response = (await foodDetailRepo.getFoodDetail(id));
    if (response.statusCode == 200) {
      _foodsDetail = null;
      _foodsDetail = FoodTopping.fromJson(jsonDecode(response.body));
      _toppingFood = [];
      _toppingFood.addAll(FoodTopping.fromJson(jsonDecode(response.body)).listTopping);
      _isLoaded = true;
      update();
      // return _foodsDetail;
      return true;
    } else {
      return false;
      // return false;
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity! + 1;
    } else {
      _quantity = checkQuantity(_quantity! - 1);
    }
    ;
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity < 1) {
      Get.snackbar("Không hợp lệ", "Bạn không thể xóa thêm",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 1;
    }
    return quantity;
  }

  void initFood(FoodTopping food, CartController cart) {
    _quantity = 1;
    _inCartItems = 0;
    _listTopping=[];
    _cart = cart;
    totalMoney=0;
    var exist = false;
    exist = _cart.existInCart(food);
    if(exist){
      _inCartItems=_cart.getQuantity(food);
    }
  }

  void addItem(FoodTopping food, String storeID) {
    if (quantity > 0) {
      if(checkStore(storeID)){
        _cart.addItem(food, _quantity,listTopping,storeID);
      }
      _quantity = 1;
      _inCartItems=_cart.getQuantity(food);
    } else {
      Get.snackbar("Không hợp lệ", "Bạn chưa chọn số lượng",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
    update();
  }
  bool checkStore(storeID){
    if(getItems.isEmpty){
      return true;
    }
    if(getItems[0].storeID==storeID){
      return true;
    }
    Get.snackbar("Không hợp lệ", "Vui lòng thanh toán đơn hàng hiện tại",
        backgroundColor: AppColors.mainColor, colorText: Colors.white);
    return false;
  }
  int get totalItems{
    return _cart.totalItems;
  }
  var check=false;
  void addTopping(isSelected, toppingID){
    if(isSelected){
      _listTopping.remove(toppingID);
      totalMoney=(totalMoney!-toppingID.price) as int?;
    }else{
      _listTopping.add(toppingID);
      totalMoney=(totalMoney!+toppingID.price) as int?;
    }
    update();
  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }
}
