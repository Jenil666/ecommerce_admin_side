// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreenController extends GetxController
{
  Future<void> getAdminData()
  async {
    QuerySnapshot? querySnap = await FireBaseHelper.fireBaseHelper.verifyAdmin();
    var data = querySnap.docs;
    print('Data');
    print(data[0]['uid']);
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

//ToDo General Variable
  RxBool chechCircularProgressIndicator = false.obs;
  RxString buttonText = "Create Account".obs;
}