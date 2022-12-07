import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/foodOfStore_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class SearchStore extends SearchDelegate<String> {
  final List<dynamic> allStore;
  final List<dynamic> storeSuggestion;
  SearchStore({required this.allStore, required this.storeSuggestion});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon:const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> allStores = allStore
        .where(
            (store) => store.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: allStores.isEmpty?0:allStores.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () async {
              bool check=await Get.find<FoodOfStoreController>().getAllFoodOfStore(allStores[index].storeId!, "16.073877", "108.149892");
              if(check){
                Get.toNamed(RouteHelper.getStoreDetail(allStores[index].storeId!));
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                  bottom: ScreenUtil().setHeight(10)),
              child: Row(
                children: [
                  //image section
                  Container(
                    width: ScreenUtil().setWidth(80),
                    height: ScreenUtil().setHeight(90),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().radius(15)),
                        color: Colors.white38,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(allStores[index].image!))),
                  ),
                  //text container
                  Expanded(
                    child: Container(
                      height: ScreenUtil().setWidth(98),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(ScreenUtil().radius(15)),
                          bottomRight: Radius.circular(ScreenUtil().radius(15)),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BigText(
                              text: allStores[index].name,
                              size: ScreenUtil().setSp(10),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            SmallText(
                              text: (allStores[index].address.split(","))[0]!,
                              maxLines: 1,
                              size: ScreenUtil().setSp(8),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconAndTextWidget(
                                    icon: Icons.location_on,
                                    text:
                                        "${(allStores[index].distance.toString().substring(0, 3))!}km",
                                    iconColor: AppColors.iconColor1),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> storeSuggestions = storeSuggestion
        .where(
            (store) => store.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: storeSuggestions.isEmpty?0:storeSuggestions.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () async {
              bool check=await Get.find<FoodOfStoreController>().getAllFoodOfStore(storeSuggestions[index].storeId!, "16.073877", "108.149892");
              if(check){
                Get.toNamed(RouteHelper.getStoreDetail(storeSuggestions[index].storeId!));
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                  bottom: ScreenUtil().setHeight(10)),
              child: Row(
                children: [
                  //image section
                  Container(
                    width: ScreenUtil().setWidth(80),
                    height: ScreenUtil().setHeight(90),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(15)),
                        color: Colors.white38,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(storeSuggestion[index].image!))),
                  ),
                  //text container
                  Expanded(
                    child: Container(
                      height: ScreenUtil().setWidth(98),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(ScreenUtil().radius(15)),
                          bottomRight: Radius.circular(ScreenUtil().radius(15)),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BigText(
                              text: storeSuggestion[index].name,
                              size: ScreenUtil().setSp(10),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            SmallText(
                              text: (storeSuggestion[index].address.split(","))[0]!,
                              maxLines: 1,
                              size: ScreenUtil().setSp(8),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconAndTextWidget(
                                    icon: Icons.location_on,
                                    text:
                                    "${(storeSuggestion[index].distance.toString().substring(0, 3))!}km",
                                    iconColor: AppColors.iconColor1),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
