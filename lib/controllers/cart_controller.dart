
import 'package:get/get.dart';
import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/food_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<String, CartModel> _items = {};
  Map<String, CartModel> get items => _items;
  List<CartModel> storageItems=[];
  String? topping;
  void addItem(FoodTopping food, int quantity, List<ListTopping> topping, String storeID) {
    var totalQuantity = 0;
    if (_items.containsKey(food.foodId!)) {
      _items.update(food.foodId!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          storeID: value.storeID,
          foodId: value.foodId,
          foodName: value.foodName,
          price: value.price,
          imageUrl: value.imageUrl,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          listFoodTopping: topping,
          food: food,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(food.foodId);
      }
    } else {
      _items.putIfAbsent(food.foodId!, () {
        return CartModel(
          storeID: storeID,
          foodId: food.foodId,
          foodName: food.name,
          price: food.price,
          imageUrl: food.urlImage,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          listFoodTopping: topping,
          food: food,
        );
      });
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  existInCart(FoodTopping food) {
    if (_items.containsKey(food.foodId)) {
      return true;
    }
    return false;
  }
  getListTopping(FoodTopping food){
    List<dynamic> toppingID=[];
    if(_items.containsKey(food.foodId)){
      _items.forEach((key, value) {
        if(key==food.foodId){
          for (var element in value.listFoodTopping) {
            toppingID.add(element.iD);
          }
        }
      });
    }
    return toppingID;

  }
  getQuantity(FoodTopping food) {
    var quantity = 0;
    if (_items.containsKey(food.foodId)) {
      _items.forEach((key, value) {
        if (key == food.foodId) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }
  List<CartModel> get getItems{
    return  _items.entries.map((e){
      return e.value;
    }).toList();
  }
  int getTotalMoneyItems(foodID){
    var totalMoney=0;
    for (var element in _items.values) {
      if(element.foodId==foodID){
        totalMoney=element.price!*element.quantity!;
        for (var element in element.listFoodTopping) {
          totalMoney+=element.price!;
        }
      }

    }
    return totalMoney;
  }
  String? getTopping(foodID){
    topping="";
    for (var element in _items.values) {
      if(element.foodId==foodID){
        for (var element in element.listFoodTopping) {
          topping="${topping!},${element.name!}";
        }
      }

    }
    return topping;
  }
  int get totalAmount{
    var total=0;
    _items.forEach((key, value) {
      total+=getTotalMoneyItems(value.foodId);
    });
    return total;
  }
  List<CartModel> getCartData(){
    setCart=cartRepo.getCartList();
    return storageItems;
  }
  set setCart(List<CartModel> items){
    storageItems=items;
    for(int i=0;i<storageItems.length;i++){
      _items.putIfAbsent(storageItems[i].food!.foodId!, () => storageItems[i]);
    }
  }
  set setItems(Map<String, CartModel> items){
    _items=items;
    update();
  }
}