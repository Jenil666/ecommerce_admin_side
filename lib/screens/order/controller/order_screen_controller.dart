import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_side/screens/order/modal/order_screen_modal.dart';
import 'package:ecommerce_admin_side/screens/order/modal/poroduct_modal.dart';
import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:get/get.dart';

class OrderScreenController extends GetxController {
  // RxList<Map> datas = <Map>[].obs;
  RxBool showProcess = false.obs;
  RxList<UserData> userData = <UserData>[].obs;
  RxList<ProductModal> productData = <ProductModal>[].obs;
  List uids = [];
  List product = [];

  void getOrderData() async {
    QuerySnapshot? querySnapshot =
        await FireBaseHelper.fireBaseHelper.readOrderData();
    var mapData = querySnapshot.docs;
    var data;
    List productArray = [];
    for (int i = 0; i < mapData.length; i++) {
      showProcess.value = true;
      uids.add(mapData[i]['Uid']);
      product.add(mapData[i]['products']);
    }
    for (int i = 0; i < product.length; i++) {
      QuerySnapshot? querySnapshot =
          await FireBaseHelper.fireBaseHelper.readDataFromId(id: product[i]);
      data = querySnapshot.docs;
      Timer(Duration(seconds: 1), () {
        ProductModal p1 = ProductModal(
          productCompany: data[0]['Company'],
          productCategory: data[0]['Catedory'],
          productQuantity: data[0]['Quantity'],
          productPrice: data[0]['Price'],
          productName: data[0]['Name'],
          productDiscountedPrice: data[0]['Discounted Price'],
          productDiscount: data[0]['Discount'],
          productDescription: data[0]['Description'],
          productId: data[0].id,
          productImage: data[0]['image'],
        );
        productData.add(p1);
        print("====================== data check ");
        // print(    productData[i].productName);
        print(data[0].id);
      });
    }
  }

  Future<void> getUserDatas() async {
    for (int i = 0; i < uids.length; i++) {
      QuerySnapshot? querySnashort =
          await FireBaseHelper.fireBaseHelper.readUserDataBaseOnUid(uids[i]);
      var userDatas = querySnashort.docs;
      String name = userDatas[0]['Name'];
      String address = userDatas[0]['Address'];
      String uid = userDatas[0]['Uid'];
      String fmcToken = userDatas[0]['FmcToken'];
      String email = userDatas[0]['Email'];
      String mobileNumber = userDatas[0]['Mobile Number'];
      UserData u1 = UserData(
          name: name,
          email: email,
          address: address,
          mobileNumber: mobileNumber,
          fmctoken: fmcToken,
          Uid: uid);
      userData.add(u1);
    }
    showProcess.value = false;
  }
}
