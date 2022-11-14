class User {
  String? id;
  String? name;
  String? email;
  String? photo;
  String? phone;
  List<String>? roles;
  List<String>? get getRoles=>roles;
  String? accessToken;
  late String? refreshToken;

  User(
      {this.id,
        this.name,
        this.email,
        this.photo,
        this.phone,
        this.roles,
        this.accessToken,
        this.refreshToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    phone = json['phone'];
    roles = json['roles'].cast<String>();
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['phone'] = this.phone;
    data['roles'] = this.roles;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}