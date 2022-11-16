class Store {
  String? storeId;
  String? name;
  int? numOfReview;
  int? star;
  double? distance;
  String? address;
  String? image;

  Store(
      {this.storeId,
        this.name,
        this.numOfReview,
        this.star,
        this.distance,
        this.address,
        this.image});

  Store.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    name = json['name'];
    numOfReview = json['numOfReview'];
    star = json['start'];
    distance = json['disstance'];
    address = json['address'];
    image = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeId'] = this.storeId;
    data['name'] = this.name;
    data['numOfReview'] = this.numOfReview;
    data['start'] = this.star;
    data['disstance'] = this.distance;
    data['address'] = this.address;
    data['img'] = this.image;
    return data;
  }
}