import 'dart:async';

import 'package:ecommerce_admin_side/screens/order/controller/order_screen_controller.dart';
import 'package:ecommerce_admin_side/screens/register/view/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderScreenController getxOrderScreenController = Get.put(OrderScreenController());
  @override
  void initState() {
    super.initState();
    getxOrderScreenController.getOrderData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffF7F6F4),
          appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text("Order Screen"),
        ),
        body: getxOrderScreenController.userData != []?Obx(
          () =>  ListView.builder(
            itemCount: getxOrderScreenController.userData.value.length,
            itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              color: const Color(0xdbe5e5e5),
              child: ListTile(
                title: Text("${getxOrderScreenController.userData[index].name}"),
                subtitle: Text("${getxOrderScreenController.userData[index].email}"),
                trailing: IconButton(
                  onPressed: () {
                    Get.toNamed('/userOrder',arguments: index);
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },),
        ):Center(child: CircularProgressIndicator(color: Colors.deepOrange,),)),
    );
  }
}
