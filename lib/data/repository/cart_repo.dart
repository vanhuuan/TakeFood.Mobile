import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});
  List<String> cart=[];
  void addToCartList(List<CartModel> cartList){
    cart=[];
    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });
    print(cart.toString());
    sharedPreferences.setStringList("Cart-list", cart);
    getCartList();
  }
  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey("Cart-list")){
      carts=sharedPreferences.getStringList("Cart-list")!;
    }
    List<CartModel> cartList=[];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    cartList.forEach((element) {
      print(element.quantity.toString());
    });
    return cartList;
  }
}