import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_side/utils/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/fire_base_helper.dart';
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
  Widget build(BuildContext context) {
    try
        {
          return SafeArea(child: Scaffold(
            appBar: AppBar(backgroundColor: Colors.orangeAccent,title: Text("User Order"),),
            body: Obx(
                  () => getxOrderScreenController.userData.isNotEmpty ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      height: 25.h,
                      child: CachedNetworkImage(imageUrl: '${getxOrderScreenController.productData[data].productImage}',progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator(color: Colors.deepOrange,),),),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text('Product Details',style: TextStyle(fontSize: 15.sp),),
                      ],
                    ),
                    Card(
                      elevation: 5,
                      semanticContainer: true,
                      shadowColor: Colors.deepOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Name',style: TextStyle(fontSize: 12.sp),),
                                Spacer(),
                                Text("${getxOrderScreenController.productData[data].productName}")
                              ],
                            ),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                Text('Price',style: TextStyle(fontSize: 12.sp),),
                                Spacer(),
                                Text("${getxOrderScreenController.productData[data].productPrice}")
                              ],
                            ),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                Text('Category',style: TextStyle(fontSize: 12.sp),),
                                Spacer(),
                                Text("${getxOrderScreenController.productData[data].productCategory}")
                              ],
                            ),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                Text('Company',style: TextStyle(fontSize: 12.sp),),
                                Spacer(),
                                Text("${getxOrderScreenController.productData[data].productCompany}")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Text('Customer Details',style: TextStyle(fontSize: 15.sp),),
                      ],
                    ),
                    Card(
                      elevation: 5,
                      semanticContainer: true,
                      shadowColor: Colors.deepOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Name',style: TextStyle(fontSize: 12.sp),),
                                Spacer(),
                                Text("${getxOrderScreenController.userData[data].name}")
                              ],
                            ),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                Text('Email',style: TextStyle(fontSize: 12.sp),),
                                Spacer(),
                                Text("${getxOrderScreenController.userData[data].email}")
                              ],
                            ),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                Text('Contact Details',style: TextStyle(fontSize: 12.sp),),
                                Spacer(),
                                Text("${getxOrderScreenController.userData[data].mobileNumber}")
                              ],
                            ),
                            SizedBox(height: 3,),
                            ExpansionTile(
                                textColor: Colors.deepOrange,
                                iconColor: Colors.deepOrange,
                                title: Text("Address"),children: [Text("${getxOrderScreenController.userData[data].address}")
                            ]),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Obx(
                          () =>  InkWell(
                        onTap: () async {
                          getxOrderScreenController.circularProgressIndicatorForDispatchButton.value = true;
                          bool check = await FireBaseHelper.fireBaseHelper.addDataInDispatchCollection(productId: getxOrderScreenController.productData[data].productId,Uid: getxOrderScreenController.userData[data].Uid);
                          if(check == true)
                          {
                            bool verify = await FireBaseHelper.fireBaseHelper.deleteDataFromOrderCollection(aid: getxOrderScreenController.autoIdsOfBuyCollection[data]);
                            if(verify == true && getxOrderScreenController.circularProgressIndicatorForDispatchButton == false)
                            {
                              ApiHelper.apiHelper.dispatchProductNotification("${getxOrderScreenController.userData[data].fmctoken}", "Ecommerce", "${getxOrderScreenController.productData[data].productName} is dispatcher", "${getxOrderScreenController.productData[data].productImage}");
                              Get.back();
                            }
                          }
                        },
                        child: Container(
                          height: 8.h,
                          width: 100.w,
                          color: Colors.orange.shade200,
                          alignment: Alignment.center,
                          child: getxOrderScreenController.circularProgressIndicatorForDispatchButton==false?Text("Dispatch Product",style: TextStyle(color: Colors.deepOrange,fontSize: 12.sp),):Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
                        ),
                      ),
                    ),
                  ],
                ),
              ):Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
            ),
          ),);
        }
        catch(e)
    {
      return Container();
    }
  }
}
