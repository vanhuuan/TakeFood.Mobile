class VoucherStore {
  String? voucherId;
  String? name;
  String? code;
  String? description;
  int? minSpend;
  int? amount;
  int? maxDiscount;
  String? startDate;
  String? endDate;
  String? createDate;
  String? updateDate;

  VoucherStore(
      {this.voucherId,
        this.name,
        this.code,
        this.description,
        this.minSpend,
        this.amount,
        this.maxDiscount,
        this.startDate,
        this.endDate,
        this.createDate,
        this.updateDate});

  VoucherStore.fromJson(Map<String, dynamic> json) {
    voucherId = json['voucherId'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    minSpend = json['minSpend'].toInt();
    amount = json['amount'].toInt() ;
    maxDiscount = json['maxDiscount'].toInt();
    startDate = json['startDate'];
    endDate = json['endDate'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voucherId'] = this.voucherId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['minSpend'] = this.minSpend;
    data['amount'] = this.amount;
    data['maxDiscount'] = this.maxDiscount;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    return data;
  }
}