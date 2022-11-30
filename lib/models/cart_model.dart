import 'food_model.dart';

class CartModel {
  String? storeID;
  String? foodId;
  String? foodName;
  int? price;
  String? imageUrl;
  int? quantity;
  bool? isExist;
  String? time;
  late List<ListTopping> _listFoodTopping;
  List<ListTopping> get listFoodTopping=>_listFoodTopping;
  FoodTopping? food;


  CartModel({
    this.storeID,
    this.foodId,
    this.foodName,
    this.price,
    this.imageUrl,
    this.quantity,
    this.isExist,
    this.time,
    required listFoodTopping,
    this.food
  }
      ){
    _listFoodTopping=listFoodTopping;
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    storeID=json['storeID'];
    foodId = json['foodId'];
    foodName = json['foodName'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    quantity=json['quantity'];
    isExist=json['isExist'];
    time=json['time'];
    if (json['ListTopping'] != null) {
      _listFoodTopping = <ListTopping>[];
      json['ListTopping'].forEach((v) {
        listFoodTopping!.add(new ListTopping.fromJson(v));
      });
    }
    food=FoodTopping.fromJson(json['food']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeID']=this.storeID;
    data['foodId'] = this.foodId;
    data['foodName'] = this.foodName;
    data['quantity']=this.quantity;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    if (this.listFoodTopping != null) {
      data['ListTopping'] = this.listFoodTopping!.map((v) => v.toJson()).toList();
    };
    data['food']=this.food!.toJson();
    return data;
  }
}