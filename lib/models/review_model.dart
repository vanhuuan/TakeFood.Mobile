class Review {
  String? description;
  String? userName;
  int? star;
  List<String>? images;

  Review({this.description, this.userName, this.star, this.images});

  Review.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    userName = json['userName'];
    star = json['star'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['userName'] = this.userName;
    data['star'] = this.star;
    data['images'] = this.images;
    return data;
  }
}