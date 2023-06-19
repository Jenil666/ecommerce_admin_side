import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController
{


  RxList cate = [].obs;
  String? id;
  RxBool checkAddCategory = true.obs;
  RxList<DropdownMenuEntry> menuItems = <DropdownMenuEntry>[].obs;

  getCategory() async{
    QuerySnapshot querySnapshot = await FireBaseHelper.fireBaseHelper.readCategoryData();
    List m1 = querySnapshot.docs ;
    id = m1[0].id;
    cate.value = m1[0]['data'];
    menuItems.clear();
    for(int i=0;i<cate.length;i++)
      {
        menuItems.add(
          DropdownMenuEntry(value: cate[i], label: cate[i]),
        );
      }
  }


  TextEditingController txtProductName = TextEditingController();
  TextEditingController txtProductPrice = TextEditingController();
  TextEditingController txtProductQuantity = TextEditingController();
  TextEditingController txtProductDiscount = TextEditingController();
  TextEditingController txtProductDiscountedPrice = TextEditingController();
  TextEditingController txtProductCompany = TextEditingController();
  TextEditingController txtProductCategory = TextEditingController();
  TextEditingController txtProductDescription = TextEditingController();
  TextEditingController txtProductImage = TextEditingController(text: "https://sun9-57.userapi.com/5LaM1quvZBUHROPNJeFRwggW6v95Alr2xlVsNw/ba3Q_NrAQaA.jpg");
  TextEditingController txtUpdateSingleCategory = TextEditingController();
  TextEditingController txtAddCategory = TextEditingController();
  TextEditingController txtProductReview = TextEditingController();
  TextEditingController txtProductTotalReview = TextEditingController();
}