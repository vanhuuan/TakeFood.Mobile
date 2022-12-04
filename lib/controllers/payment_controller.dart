import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repository/payment_repo.dart';
import '../models/user_model.dart';
import '../models/voucher_model.dart';
import '../routes/route_helper.dart';
import 'cart_controller.dart';
import 'myOrdered_controller.dart';


class PaymentController extends GetxController{
  final PaymentRepo paymentRepo;
  final CartController cartController;
  List<dynamic> _listVoucher=[];
  List<dynamic> get listVoucher=>_listVoucher;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  String voucherID="not yet";
  num amountDiscount=0;
  String addressUser="";
  String phoneNumberUser="";
  late User user;
  PaymentController({required this.paymentRepo,required this.cartController})  {
     initUser();
  }
  Future<bool> getVoucher(id) async {
    http.Response response = (await paymentRepo.getVoucher(id));
    if (response.statusCode == 200) {
      _listVoucher=[];
      List<dynamic>  decodedList = json.decode(response.body);
      List<VoucherStore> posts = List<VoucherStore>.from(decodedList.map((model)=> VoucherStore.fromJson(model)));
      _listVoucher.addAll(posts);
      _isLoaded=true;
      update();
      // return _foodsDetail;
      return true;
    } else {
      _isLoaded=false;
      return false;
      // return false;
    }
  }
  initUser() async {
    String? getUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await paymentRepo.getUser();
    addressUser=prefs.getString("address")!;
    if(prefs.containsKey("user")){
      getUser=prefs.getString("user");
      user=User.fromJson(jsonDecode(getUser!));
      phoneNumberUser=user.phone.toString();
    }
    update();
  }
  checkVoucher(VoucherStore voucher){
    int amount=cartController.totalAmount;
     amountDiscount=0;
    if(amount>=voucher.minSpend!){
      double discount=(amount*voucher.amount!/100);
      amountDiscount=discount.floor();
      if(amountDiscount>voucher.maxDiscount!){
        amountDiscount=voucher.maxDiscount!;
      }
      voucherID=voucher.voucherId!;
    }
    update();
    return amountDiscount;
  }
  getTotal(){
    return cartController.totalAmount-amountDiscount;
  }
  Future<bool> confirmOrder(String note) async {
    _isLoaded=false;
    print(voucherID);
    if(note.isEmpty) {
      note="Nothing";
    }
    bool checkOrder=await paymentRepo.confirmOrder(voucherID,note,addressUser,phoneNumberUser);
    if(checkOrder){
      await Get.find<MyOrderController>().getListMyOrdered();
      clear();
      cartController.getCartData();
      return true;
    }else{
      Get.toNamed(RouteHelper.homepage);
    }
    return false;
  }
  editInfoUser(data){
    try{
    addressUser=data["address"];
    phoneNumberUser=data["phoneNumber"];
    update();
    return true;
    }catch(e){
      return false;
    }
  }
  void clear(){
    cartController.setItems={};
    update();
  }
}