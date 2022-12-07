import 'dart:io';
import 'package:cdcn/base/show_custom_snackbar.dart';
import 'package:cdcn/controllers/myOrdered_controller.dart';
import 'package:cdcn/widgets/big_text.dart';
import 'package:cdcn/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class DetailOrderPage extends StatefulWidget {
  const DetailOrderPage({Key? key}) : super(key: key);

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadFile();
      } else {
        showCustomSnackBar("Vui lòng chọn ảnh", title: "Lỗi");
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadFile();
      } else {
        showCustomSnackBar("Vui lòng chọn ảnh", title: "Lỗi");
      }
    });
  }

  Future<String> uploadFile() async {
    if (_photo == null) {
      return "";
    }
    final fileName = _photo!.path;
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      showCustomSnackBar("Vui lòng thử lại", title: "Lỗi");
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    // var rateText = TextEditingController();
    // int ratingStar=1;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Center(child: Text("Chi tiết đơn hàng")),
        ),
        body: GetBuilder<MyOrderController>(builder: (ordered) {
          var isReview = false;
          var rateText = TextEditingController();
          int? ratingStar = 5;
          final review = ordered.review;
          if (review != null) {
            rateText =
                TextEditingController(text: review.description.toString());
            ratingStar = review.star;
            isReview = true;
          }

          return ordered.isLoaded
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(4),
                            left: ScreenUtil().setWidth(20),
                            right: ScreenUtil().setWidth(10)),
                        height: ScreenUtil().setHeight(200),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColors.borderBottom,
                                    width: 5.0))),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(200),
                              width: ScreenUtil().setWidth(140),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(
                                      text: "Mã đơn hàng:",
                                      size: ScreenUtil().setSp(8)),
                                  SmallText(
                                      text: "Tên:",
                                      size: ScreenUtil().setSp(8)),
                                  SmallText(
                                      text: "Số điện thoại:",
                                      size: ScreenUtil().setSp(8)),
                                  SmallText(
                                      text: "Địa chỉ:",
                                      size: ScreenUtil().setSp(8)),
                                  SmallText(
                                    text: "Thời gian đặt hàng:",
                                    size: ScreenUtil().setSp(8),
                                  ),
                                ],
                              ),
                            ),
                            GetBuilder<MyOrderController>(
                                builder: (detailOrder) {
                              return Container(
                                height: ScreenUtil().setHeight(200),
                                width: ScreenUtil().setWidth(230),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SmallText(
                                      text: detailOrder.detailOrdered.orderId,
                                      color: AppColors.mainBlackColor,
                                      size: ScreenUtil().setSp(8.5),
                                      maxLines: 1,
                                    ),
                                    SmallText(
                                      text: detailOrder.nameUser!,
                                      color: AppColors.mainBlackColor,
                                      size: ScreenUtil().setSp(8.5),
                                      maxLines: 1,
                                    ),
                                    SmallText(
                                      text:
                                          detailOrder.detailOrdered.phoneNumber,
                                      color: AppColors.mainBlackColor,
                                      size: ScreenUtil().setSp(8.5),
                                      maxLines: 1,
                                    ),
                                    SmallText(
                                      text: detailOrder.detailOrdered.address,
                                      color: AppColors.mainBlackColor,
                                      size: ScreenUtil().setSp(8.5),
                                      maxLines: 1,
                                    ),
                                    SmallText(
                                      text: detailOrder.dateOrdered,
                                      color: AppColors.mainBlackColor,
                                      size: ScreenUtil().setSp(8.5),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              );
                            })
                          ],
                        )),
                    // SizedBox(height: ScreenUtil().setHeight(210),),
                    Container(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(4),
                            left: ScreenUtil().setWidth(20),
                            right: ScreenUtil().setWidth(10)),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmallText(
                              text: "Đơn hàng của bạn",
                              color: const Color(0xFFFF8357),
                              fontWeight: "bold",
                              size: ScreenUtil().setSp(8),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            BigText(text: ordered.detailOrdered.storeName!),
                            Row(
                              children: [
                                SmallText(
                                  text: ordered.detailOrdered.state,
                                  size: ScreenUtil().setSp(8),
                                  color: AppColors.mainBlackColor,
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(5),
                                ),
                                AppIcon(
                                  icon: Icons.check,
                                  size: ScreenUtil().setHeight(20),
                                  iconSize: ScreenUtil().setHeight(15),
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                ),
                              ],
                            ),
                            ListView.builder(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(5)),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ordered.listFood?.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    // height: ScreenUtil().setHeight(50),
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.borderBottom,
                                                width: 1.0))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SmallText(
                                                  text:
                                                      "${ordered.listFood[index].quantity}x",
                                                  color: Colors.black,
                                                  fontWeight: "bold",
                                                  size: ScreenUtil().setSp(8),
                                                ),
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().setWidth(10),
                                                ),
                                                SmallText(
                                                  text: ordered.listFood[index]
                                                      .foodName!,
                                                  fontWeight: "bold",
                                                  size: ScreenUtil().setSp(11),
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                            SmallText(
                                              text: ordered
                                                  .listFood[index].total
                                                  .toString(),
                                              fontWeight: "bold",
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                        ordered.listFood[index].toppings!
                                                .isEmpty
                                            ? Container()
                                            : ListView.builder(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(5)),
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: ordered
                                                    .listFood[index]
                                                    .toppings
                                                    ?.length,
                                                itemBuilder: (context, INDEX) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SmallText(
                                                            text:
                                                                "${ordered.listFood[index].toppings?[INDEX].quantity}x",
                                                            color: Colors.black,
                                                            size: ScreenUtil()
                                                                .setSp(6),
                                                          ),
                                                          SizedBox(
                                                            width: ScreenUtil()
                                                                .setWidth(10),
                                                          ),
                                                          SmallText(
                                                            text: ordered
                                                                .listFood[index]
                                                                .toppings![
                                                                    INDEX]
                                                                .toppingName
                                                                .toString(),
                                                            color: Colors.black,
                                                            size: ScreenUtil()
                                                                .setSp(8),
                                                          ),
                                                        ],
                                                      ),
                                                      SmallText(
                                                          text: ordered
                                                              .listFood[index]
                                                              .toppings![INDEX]
                                                              .total
                                                              .toString(),
                                                          color: Colors.black,
                                                          size: ScreenUtil()
                                                              .setSp(8))
                                                    ],
                                                  );
                                                }),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(10),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(4),
                                  left: ScreenUtil().setWidth(20),
                                  right: ScreenUtil().setWidth(10)),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: AppColors.borderBottom,
                                          width: 1.0))),
                              width: double.maxFinite,
                              child: Column(
                                children: [
                                  ordered.detailOrdered.discount == 0
                                      ? SizedBox(
                                          height: ScreenUtil().setHeight(1),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SmallText(
                                              text: "Giảm giá:",
                                              color: AppColors.mainBlackColor,
                                            ),
                                            SmallText(
                                                text:
                                                    "-${ordered.detailOrdered.discount.toString()}",
                                                color:
                                                    AppColors.mainBlackColor),
                                          ],
                                        ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SmallText(
                                        text: "Tổng cộng:",
                                        color: AppColors.mainBlackColor,
                                      ),
                                      SmallText(
                                          text: ordered.detailOrdered.total
                                              .toString()
                                              ,
                                          color: Colors.redAccent),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(4),
                                  left: ScreenUtil().setWidth(20),
                                  right: ScreenUtil().setWidth(10)),
                              height: ScreenUtil().setHeight(50),
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SmallText(
                                      text: "Phương thức thanh toán:",
                                      fontWeight: "bold",
                                      color: Colors.black),
                                  SmallText(
                                      text: "Tiền mặt", color: Colors.black),
                                ],
                              ),
                            ),
                            ordered.detailOrdered.state == "Delivered"
                                ? Container(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(4),
                                        left: ScreenUtil().setWidth(20),
                                        right: ScreenUtil().setWidth(10)),
                                    //height: ScreenUtil().setHeight(70),
                                    width: double.maxFinite,
                                    child: Column(
                                      children: [
                                        SmallText(text: "Đánh giá đơn hàng"),
                                        RatingBar.builder(
                                          initialRating: ratingStar!.toDouble(),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          itemSize: 30,
                                          ignoreGestures: true,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            ratingStar = rating.toInt();
                                          },
                                        ),
                                        TextField(
                                          controller: rateText,
                                          obscureText: false,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: "Thêm nhận xét",
                                            hintStyle: TextStyle(
                                                color: Color(0xFFFF8357),
                                                fontSize:
                                                    ScreenUtil().setSp(10)),
                                            prefixIcon: const Icon(
                                              Icons.assessment_rounded,
                                              color: Color(0xFFFF8357),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 1,
                                              color: AppColors.borderBottom,
                                            )),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 1,
                                              color: AppColors.borderBottom,
                                            )),
                                          ),
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(10)),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(5),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  _showPicker(context);
                                                },
                                                child: CircleAvatar(
                                                  radius: 55,
                                                  backgroundColor:
                                                      AppColors.mainColor,
                                                  child: _photo != null ||
                                                          ordered.review != null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: ordered
                                                                      .review !=
                                                                  null
                                                              ? Image.network(
                                                                  ordered
                                                                      .review!
                                                                      .images!
                                                                      .first,
                                                                  width: 100,
                                                                  height: 100,
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  errorBuilder: (BuildContext
                                                                          context,
                                                                      Object
                                                                          exception,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                    return const Text(
                                                                        "...");
                                                                  },
                                                                )
                                                              : Image.file(
                                                                  _photo!,
                                                                  width: 100,
                                                                  height: 100,
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                ),
                                                        )
                                                      : Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[200],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          width: 100,
                                                          height: 100,
                                                          child: Icon(
                                                            Icons.camera_alt,
                                                            color: Colors
                                                                .grey[800],
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (!isReview) {
                                              if (rateText.text.isEmpty) {
                                                showCustomSnackBar(
                                                    "Vui lòng thêm nhận xét",
                                                    title: "Bổ sung");
                                              } else {
                                                String url = await uploadFile();
                                                if (url.isEmpty) {
                                                  showCustomSnackBar(
                                                      "Vui lòng chọn ảnh",
                                                      title: "Lỗi");
                                                }
                                                if (url.isNotEmpty &&
                                                    rateText.text.isNotEmpty) {
                                                  var data = {
                                                    'orderId': ordered
                                                        .detailOrdered.orderId,
                                                    'description': rateText.text
                                                        .toString(),
                                                    'star': ratingStar,
                                                    'images': [url]
                                                  };
                                                  bool check = await ordered
                                                      .reviewOrder(data);
                                                  if (check == false) {
                                                    showCustomSnackBar(
                                                        "Vui  lòng thử lại",
                                                        title: "Lỗi hệ thống");
                                                  } else {
                                                    showCustomSnackBar(
                                                        "Cảm ơn bạn đã đánh giá",
                                                        title: "Thành công",
                                                        type: false);
                                                    ordered.getReviewByorderId(
                                                        ordered.detailOrdered
                                                            .orderId);
                                                    setState(() {
                                                      isReview = true;
                                                    });
                                                  }
                                                }
                                              }
                                            }
                                          },
                                          child: isReview == false
                                              ? SmallText(
                                                  text: "Đánh giá",
                                                  color:
                                                      AppColors.mainBlackColor,
                                                  fontWeight: "bold",
                                                )
                                              : SmallText(
                                                  text: "Đã đánh giá",
                                                  color: AppColors.paraColor,
                                                  fontWeight: "bold",
                                                ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container()
                          ],
                        ))
                  ],
                ))
              : Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
        }));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
