class Order {
  String? address;
  String? addressId;
  String? note;
  String? phoneNumber;
  String? voucherId;
  String? paymentMethod;
  String? deliveryMode;
  String? storeId;
  List<FoodOrder>? foodOrder;

  Order(
      {this.address,
        this.addressId,
        this.note,
        this.phoneNumber,
        this.voucherId,
        this.paymentMethod,
        this.deliveryMode,
        this.storeId,
        this.foodOrder
      });

  Order.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressId = json['addressId'];
    note = json['note'];
    phoneNumber = json['phoneNumber'];
    voucherId = json['voucherId'];
    paymentMethod = json['paymentMethod'];
    deliveryMode = json['deliveryMode'];
    storeId = json['storeId'];
    if (json['listFood'] != null) {
      foodOrder = <FoodOrder>[];
      json['listFood'].forEach((v) {
        foodOrder!.add(new FoodOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['addressId'] = this.addressId;
    data['note'] = this.note;
    data['phoneNumber'] = this.phoneNumber;
    data['voucherId'] = this.voucherId;
    data['paymentMethod'] = this.paymentMethod;
    data['deliveryMode'] = this.deliveryMode;
    data['storeId'] = this.storeId;
    if (this.foodOrder != null) {
      data['listFood'] = this.foodOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodOrder {
  String? foodId;
  List<ToppingOrder>? toppingOrder;
  int? quantity;

  FoodOrder({this.foodId, this.toppingOrder, this.quantity});

  FoodOrder.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'];
    if (json['listTopping'] != null) {
      toppingOrder = <ToppingOrder>[];
      json['listTopping'].forEach((v) {
        toppingOrder!.add(new ToppingOrder.fromJson(v));
      });
    }
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodId'] = this.foodId;
    if (this.toppingOrder != null) {
      data['listTopping'] = this.toppingOrder!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class ToppingOrder {
  String? toppingId;
  int? quantity;

  ToppingOrder({this.toppingId, this.quantity});

  ToppingOrder.fromJson(Map<String, dynamic> json) {
    toppingId = json['toppingId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toppingId'] = this.toppingId;
    data['quantity'] = this.quantity;
    return data;
  }
}
