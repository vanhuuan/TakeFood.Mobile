class FoodStore {
  String? storeId;
  String? storeName;
  String? address;
  String? phoneNumber;
  double? distance;
  int? star;
  int? numOfOrder;
  int? numOfReview;
  String? imgUrl;
  late List<Foods> _foods;
  List<Foods> get foods=>_foods;


  FoodStore(
      {this.storeId,
        this.storeName,
        this.address,
        this.phoneNumber,
        this.distance,
        this.star,
        this.numOfOrder,
        this.numOfReview,
        this.imgUrl,
        required foods}){
          _foods=foods;
  }

  FoodStore.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    storeName = json['storeName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    distance = json['distance'];
    star = json['star'];
    numOfOrder = json['numOfOrder'];
    numOfReview = json['numOfReview'];
    imgUrl = json['imgUrl'];
    if (json['foods'] != null) {
      this._foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(new Foods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeId'] = this.storeId;
    data['storeName'] = this.storeName;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['distance'] = this.distance;
    data['star'] = this.star;
    data['numOfOrder'] = this.numOfOrder;
    data['numOfReview'] = this.numOfReview;
    data['imgUrl'] = this.imgUrl;
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Foods {
  String? foodId;
  String? foodName;
  int? price;
  String? imageUrl;

  Foods({this.foodId, this.foodName, this.price, this.imageUrl});

  Foods.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'];
    foodName = json['foodName'];
    price = json['price'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodId'] = this.foodId;
    data['foodName'] = this.foodName;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}