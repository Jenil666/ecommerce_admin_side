import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInScreenController extends GetxController
{
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