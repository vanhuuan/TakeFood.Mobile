class MyOrdered {
  String? orderId;
  String? storeName;
  String? state;
  int? total;
  int? foodQuantity;

  MyOrdered(
      {this.orderId,
        this.storeName,
        this.state,
        this.total,
        this.foodQuantity});

  MyOrdered.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    storeName = json['storeName'];
    state = json['state'];
    total = json['total'];
    foodQuantity = json['foodQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['storeName'] = this.storeName;
    data['state'] = this.state;
    data['total'] = this.total;
    data['foodQuantity'] = this.foodQuantity;
    return data;
  }
}