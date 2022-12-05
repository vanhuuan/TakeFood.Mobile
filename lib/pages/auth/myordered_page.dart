
import 'package:cdcn/controllers/myOrdered_controller.dart';
import 'package:cdcn/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../utils/colors.dart';
import 'myOrderedByType_page.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyOrderController>(builder: (myOrdered){
      return Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: controller,
              labelStyle: TextStyle(fontSize: 10),
              physics: BouncingScrollPhysics(),

              isScrollable: true,
              tabs: const [
                Tab(text: "Đã đặt"),
                Tab(
                  text: "Đang xử lí",
                ),
                Tab(
                  text: "Đang giao",
                ),
                Tab(
                  text: "Đã giao",
                ),
              ],
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteHelper.homepage, (route) => false),
            ),
            backgroundColor: AppColors.mainColor,
            title: Text("Đơn hàng của tôi"),
            centerTitle: true,
          ),
          body: Navigator(
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (_) => TabBarView(
                controller: controller,
                children: [
                  MyOrderedByType(data: myOrdered.listMyOrderedOrdered),
                  MyOrderedByType(data: myOrdered.listMyOrderedProcessing),
                  MyOrderedByType(data: myOrdered.listMyOrderedDelivering),
                  MyOrderedByType(data: myOrdered.listMyOrderedDelivered),

                ],
              ),
            ),
          ));
    });
  }
}
