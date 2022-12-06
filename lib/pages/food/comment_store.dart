import 'package:cdcn/controllers/foodOfStore_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/small_text.dart';

class CommentStore extends StatelessWidget {
  const CommentStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Center(child: Text("Đánh giá")),
        ),
        body: SingleChildScrollView(
          child: GetBuilder<FoodOfStoreController>(builder: (commentStore) {
            return commentStore.isLoaded
                ? commentStore.listCommentStore.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: commentStore.listCommentStore.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(4),
                                left: ScreenUtil().setWidth(30),
                                right: ScreenUtil().setWidth(20)),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.borderBottom,
                                      width: 2.0)),
                            ),
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                  text: commentStore
                                      .listCommentStore[index].userName,
                                  color: AppColors.mainColor,
                                  size: 8,
                                ),
                                RatingBar.builder(
                                  initialRating: commentStore
                                      .listCommentStore[index].star
                                      .toDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemSize: 20,
                                  tapOnlyMode: true,
                                  ignoreGestures: true,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    //ratingStar=rating.toInt();
                                  },
                                ),
                                SmallText(
                                    text: commentStore
                                        .listCommentStore[index].description
                                        .toString()!,
                                    color: AppColors.mainBlackColor),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(80),
                                  height: ScreenUtil().setHeight(90),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().radius(15)),
                                      color: Colors.white38,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(commentStore
                                              .listCommentStore[index]
                                              .images[0]))),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                              ],
                            ),
                          );
                        })
                    : Center(
                        child: SmallText(
                        text: "Chưa có đánh giá nào",
                        color: AppColors.mainBlackColor,
                        size: 10,
                      ))
                : Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  );
          }),
        ));
  }
}
