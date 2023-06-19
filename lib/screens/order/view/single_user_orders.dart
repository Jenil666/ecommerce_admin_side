import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/order_screen_controller.dart';

class SingleUserOrder extends StatefulWidget {
  const SingleUserOrder({super.key});

  @override
  State<SingleUserOrder> createState() => _SingleUserOrderState();
}

class _SingleUserOrderState extends State<SingleUserOrder> {
  OrderScreenController getxOrderScreenController = Get.put(OrderScreenController());
  int data = Get.arguments;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("+========================== index");
    print(data);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Obx(
            () =>  ListTile(
              title: Text("${getxOrderScreenController.productData[data].productPrice}"),
              subtitle: Image.network("${getxOrderScreenController.productData[data].productImage}"),
            ),
          );
        },),
    ),);
  }
}
