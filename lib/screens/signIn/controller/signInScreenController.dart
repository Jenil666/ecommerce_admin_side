import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/fire_base_helper.dart';

class SignInScreenController extends GetxController
{
  RxString uid = "".obs;
  List adminDatas = [];
  Future<void> getUid()
  async {
    // uid.value = "";
    uid.value = await FireBaseHelper.fireBaseHelper.getUid();
  }
  Future<void> getAdminData()
  async {
    // getUid();
    QuerySnapshot? querySnap = await FireBaseHelper.fireBaseHelper.verifyAdmin();
    var data = querySnap.docs;
    for(int i=0;i<data.length;i++)
      {
        adminDatas.add(data[i]['uid']);
      }
    print('======================== datas');
    print(adminDatas);
  }
  //ToDo image Variables
  String backGround = "assets/login_images/back_ground.png";
  String googleButton = "assets/login_images/google_login_button.png";
  String appleButton = "assets/login_images/apple_login_button.png";
  String facebookButton = "assets/login_images/facebook_login_button.png";

  //ToDo TextField Variables
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  RxBool showPassword = false.obs;

  //Todo General variables
  RxBool checkCircularProgressIndicator = false.obs;
  RxString buttonData = "Sign In".obs;
}