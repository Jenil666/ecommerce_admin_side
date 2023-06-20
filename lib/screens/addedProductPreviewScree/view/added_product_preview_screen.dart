import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_side/screens/addedProductPreviewScree/controller/product_preview_screen_controller.dart';
import 'package:ecommerce_admin_side/screens/addedProductPreviewScree/modal/added_product_preview_modal.dart';
import 'package:ecommerce_admin_side/utils/api_helper.dart';
import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/widgets/updateDialogForProducts/view/update_product_dialog_box.dart';

class AddedProductPreviewScreen extends StatefulWidget {
  const AddedProductPreviewScreen({super.key});

  @override
  State<AddedProductPreviewScreen> createState() =>
      _AddedProductPreviewScreenState();
}

class _AddedProductPreviewScreenState extends State<AddedProductPreviewScreen> {
  RxMap userData = {}.obs;
  ProductPreviewController getxProductPreviewController = Get.put(ProductPreviewController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData.value = FireBaseHelper.fireBaseHelper.userData();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text("Product Preview"),
        ),
        body: StreamBuilder(
          stream: FireBaseHelper.fireBaseHelper.readAdminAddedData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "${snapshot.error}",
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else if (snapshot.hasData) {
              List<AddProductPreviewModal> listData = [];
              QuerySnapshot? snapData = snapshot.data;
              for (var x in snapData!.docs) {
                // snapData.docs[0].id;
                Map? data = x.data() as Map;

                AddProductPreviewModal p1 = AddProductPreviewModal(
                  productCompany: data['Company'],
                  productCategory: data['Catedory'],
                  productQuantity: data['Quantity'],
                  productPrice: data['Price'],
                  productName: data['Name'],
                  productDiscountedPrice: data['Discounted Price'],
                  productDiscount: data['Discount'],
                  productDescription: data['Description'],
                  productId: x.id,
                  productImage: data['image'],
                  productReview: data['Review'],
                  productTotalReview: data['Total Review'],
                );
                listData.add(p1);
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onDoubleTap: () {
                      FireBaseHelper.fireBaseHelper
                          .delete(listData[index].productId);
                    },
                    onLongPress: () {
                      Get.defaultDialog(
                          title: "Update",
                          content: UpdateProductDialogBox(listData[index]));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      // color: Colors.blue,
                      child: ExpansionTile(
                          iconColor: Colors.orangeAccent,
                          textColor: Colors.orange,
                          childrenPadding: EdgeInsets.all(20),
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text("Quantity"),
                                Spacer(),
                                Text("${listData[index].productQuantity}"),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text("Company"),
                                Spacer(),
                                Text("${listData[index].productCompany}"),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text("Category"),
                                Spacer(),
                                Text("${listData[index].productCategory}"),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                          title: Row(
                            children: [
                              Container(
                                height: 6.h,
                                width: 6.h,
                                child: CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                    color: Colors.deepOrange,
                                  )),
                                  imageUrl: "${listData[index].productImage}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${listData[index].productName}"),
                                  Text("${listData[index].productPrice}"),
                                ],
                              ),
                            ],
                          )),
                    ),
                  );
                },
                itemCount: listData.length,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Obx(
                      () => userData['Photo'] != null
                          ? CircleAvatar(
                              radius: 4.h,
                              backgroundImage:
                                  NetworkImage("${userData['Photo']}"),
                            )
                          : CircleAvatar(
                              radius: 4.h,
                              backgroundImage:
                                  AssetImage("assets/images/user.png"),
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${userData['Name']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Text("${userData['Email']}"),
                      ],
                    ),
                  ],
                ),
                Divider(),
               Expanded(
                    child: ListView.builder(
                      itemCount:  getxProductPreviewController.icon.length,
                      itemBuilder: (context, index) {
                      return Obx(
                        () =>  InkWell(
                          onTap: () {
                            Timer(Duration(milliseconds: 200), () {Get.toNamed('${getxProductPreviewController.navagtin[index]}');});
                            getxProductPreviewController.index.value = index;
                          },
                          child: Container(
                          margin: EdgeInsets.only(top: 15),
                            height: 6.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: getxProductPreviewController.index==index?Colors.orange.shade100:Colors.transparent,
                                // color: ,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              child: Row(
                                children: [
                                  SizedBox(width: 15),
                                  Icon(getxProductPreviewController.icon[index], color: getxProductPreviewController.index == index?Colors.deepOrange:Colors.orangeAccent,),
                                  // Icon(Icons.messenger,color: Colors.deepOrange,),s
                                  SizedBox(width: 20),
                                  Text("${getxProductPreviewController.name[index]}",style: TextStyle(color: getxProductPreviewController.index == index?Colors.deepOrange:Colors.orangeAccent,fontSize: 15,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },),
                  ),
                // ElevatedButton(
                //     onPressed: () {
                //       // ApiHelper.apiHelper.postApi();
                //       Get.toNamed('notification');
                //     },
                //     child: Text("Send message")),
                // ElevatedButton(
                //     onPressed: () {
                //       // ApiHelper.apiHelper.postApi();
                //       Get.toNamed('dataEntry');
                //     },
                //     child: Text("Add data")),
                // ElevatedButton(
                //     onPressed: () {
                //       // ApiHelper.apiHelper.postApi();
                //       Get.toNamed('/category');
                //     },
                //     child: Text("Edit Category")),
                // ElevatedButton(
                //     onPressed: () async {
                //       Get.toNamed('/order');
                //     },
                //     child: Text("Orders Screen")),
                // Spacer(),
                // ElevatedButton(
                //     onPressed: () async {
                //       bool? check =
                //           await FireBaseHelper.fireBaseHelper.signOut();
                //       if (check == true) {
                //         Get.offNamed("/signIn");
                //       }
                //     },
                //     child: Text("Sign Out")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
