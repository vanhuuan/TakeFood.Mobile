class DetailOrdered {
  String? orderId;
  String? storeName;
  String? address;
  String? phoneNumber;
  String? paymentMethod;
  String? state;
  String? note;
  int? total;
  int? discount;
  String? orderDate;
  late List<Food>? foods;
  List<Food>? get listFoods=>foods;

  DetailOrdered(
      {this.orderId,
        this.storeName,
        this.address,
        this.phoneNumber,
        this.paymentMethod,
        this.state,
        this.note,
        this.total,
        this.discount,
        this.orderDate,
        this.foods});

  DetailOrdered.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    storeName = json['storeName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    paymentMethod = json['paymentMethod'];
    state = json['state'];
    note = json['note'];
    total = json['total'];
    discount=json['discount'];
    orderDate=json['orderDate'];
    if (json['foods'] != null) {
      foods = <Food>[];
      json['foods'].forEach((v) {
        foods!.add(new Food.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['storeName'] = this.storeName;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['paymentMethod'] = this.paymentMethod;
    data['state'] = this.state;
    data['note'] = this.note;
    data['total'] = this.total;
    data['discount']=this.discount;
    data['orderDate']=this.orderDate;
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Food {
  String? foodId;
  int? total;
  String? foodName;
  int? quantity;
  List<Toppings>? toppings;

  Food({this.foodId, this.total, this.foodName, this.quantity, this.toppings});

  Food.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'];
    total = json['total'];
    foodName = json['foodName'];
    quantity = json['quantity'];
    if (json['toppings'] != null) {
      toppings = <Toppings>[];
      json['toppings'].forEach((v) {
        toppings!.add(new Toppings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodId'] = this.foodId;
    data['total'] = this.total;
    data['foodName'] = this.foodName;
    data['quantity'] = this.quantity;
    if (this.toppings != null) {
      data['toppings'] = this.toppings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Toppings {
  String? toppingId;
  String? toppingName;
  int? total;
  int? quantity;

  Toppings({this.toppingId, this.toppingName, this.total, this.quantity});

  Toppings.fromJson(Map<String, dynamic> json) {
    toppingId = json['toppingId'];
    toppingName = json['toppingName'];
    total = json['total'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toppingId'] = this.toppingId;
    data['toppingName'] = this.toppingName;
    data['total'] = this.total;
    data['quantity'] = this.quantity;
    return data;
  }
}