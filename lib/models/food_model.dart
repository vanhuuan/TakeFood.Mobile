class FoodTopping {
  String? foodId;
  String? name;
  String? description;
  String? urlImage;
  int? price;
  String? category;
  late List<ListTopping> _listTopping;
  List<ListTopping> get  listTopping=>_listTopping;
  String? state;

  FoodTopping(
      {this.foodId,
        this.name,
        this.description,
        this.urlImage,
        this.price,
        this.category,
        required listTopping,
        this.state}){
    _listTopping=listTopping;
  }

  FoodTopping.fromJson(Map<String, dynamic> json) {
    foodId = json['FoodId'];
    name = json['Name'];
    description = json['Dscription'];
    urlImage = json['UrlImage'];
    price = json['Price'];
    category = json['Category'];
    if (json['ListTopping'] != null) {
      _listTopping = <ListTopping>[];
      json['ListTopping'].forEach((v) {
        listTopping!.add(new ListTopping.fromJson(v));
      });
    }
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FoodId'] = this.foodId;
    data['Name'] = this.name;
    data['Dscription'] = this.description;
    data['UrlImage'] = this.urlImage;
    data['Price'] = this.price;
    data['Category'] = this.category;
    if (this.listTopping != null) {
      data['ListTopping'] = this.listTopping!.map((v) => v.toJson()).toList();
    }
    data['State'] = this.state;
    return data;
  }
}

class ListTopping {
  String? iD;
  String? name;
  String? state;
  int? price;

  ListTopping({this.iD, this.name, this.state, this.price});

  ListTopping.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    state = json['State'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['State'] = this.state;
    data['Price'] = this.price;
    return data;
  }
}