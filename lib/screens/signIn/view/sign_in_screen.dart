// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:ecommerce_admin_side/screens/signIn/controller/signInScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/fire_base_helper.dart';
import '../../../utils/shr_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInScreenController getxSignInScreenController = Get.put(SignInScreenController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getxSignInScreenController.getAdminData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 100.h,
            width: 100.w,
            child: Image.asset(getxSignInScreenController.backGround,fit: BoxFit.cover,),
          ),
          Transform.translate(
              offset: Offset(0, 12.h),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Sign In as an Admin",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp,color: Colors.black),))),
          Transform.translate(
            offset: Offset(0,22.h),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 7.h,
              width: 100.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: getxSignInScreenController.txtEmail,
                  style: const TextStyle(color: Color(0xff667085)),
                  cursorColor: const Color(0xff667085),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: () {
                        getxSignInScreenController.txtEmail.clear();
                      }, icon: const Icon(Icons.cancel_outlined,color: Color(0xff667085),size: 20,),),
                      hintText: "Enter Email",
                      hintStyle: const TextStyle(color: Color(0xff4F555A)),
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none
                      )
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, 31.5.h),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 7.h,
              width: 100.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                      () =>  TextField(
                    enableSuggestions: true,
                    obscureText: getxSignInScreenController.showPassword==true?false:true,
                    controller: getxSignInScreenController.txtPassword,
                    style: const TextStyle(color: Color(0xff667085)),
                    cursorColor: const Color(0xff667085),
                    decoration: InputDecoration(
                        suffixIcon: Obx(
                              () => IconButton(onPressed: () {
                            getxSignInScreenController.showPassword.value =! getxSignInScreenController.showPassword.value;
                          }, icon: Icon(getxSignInScreenController.showPassword==false?Icons.visibility_off_outlined:Icons.visibility_outlined,color: const Color(0xff667085),size: 20,),),
                        ),
                        hintText: "Enter Password",
                        hintStyle: const TextStyle(color: Color(0xff4F555A)),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, 45.h),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(
                    () =>  InkWell(
                  onTap:() async {
                    getxSignInScreenController.checkCircularProgressIndicator.value = true;
                    getxSignInScreenController.getUid();
                    Timer(Duration(seconds: 3), () {
                      checkSignIn();
                    });
                    if((getxSignInScreenController.txtEmail.text =="") || (getxSignInScreenController.txtPassword.text ==""))
                    {
                      getxSignInScreenController.checkCircularProgressIndicator.value = false;
                      Get.snackbar("Jenil", "Enter Valid password or email");
                    }
                    else
                    {
                      bool? msg = await FireBaseHelper.fireBaseHelper.read(email: getxSignInScreenController.txtEmail.text, password: getxSignInScreenController.txtPassword.text);
                      if(msg == true)
                      {
                        // Get.offAllNamed('/navagation');
                        getxSignInScreenController.checkCircularProgressIndicator.value = false;
                        getxSignInScreenController.buttonData.value = "Tap To Continue";
                        Get.snackbar("Jenil", "Verification Completed");
                      }
                      else
                      {
                        getxSignInScreenController.checkCircularProgressIndicator.value = false;
                        getxSignInScreenController.buttonData.value = "Sign In";
                        Get.snackbar("Jenil", "Enter valid Id or Password");
                      }
                    }
                  },
                  child: Container(
                    height: 7.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff4461F2),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: getxSignInScreenController.checkCircularProgressIndicator.value==false?Text(getxSignInScreenController.buttonData.value,style: TextStyle(color: Colors.white,fontSize: 13.sp),):const CircularProgressIndicator(color: Colors.white,),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, 58.h),
            child: const Divider(
              // color: Colors.red,
              indent: 10,
              endIndent: 280,
            ),
          ),
          Transform.translate(
            offset: Offset(0, 58.h),
            child: const Divider(
              // color: Colors.red,
              indent: 280,
              endIndent: 10,
            ),
          ),
          Transform.translate(
              offset: Offset(37.w, 57.5.h),
              child: const Text("Or continue with",style: TextStyle(color: Color(0xffACADAC)),)),
          Transform.translate(
            offset: Offset(0, 65.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    bool? check = await FireBaseHelper.fireBaseHelper.sinhInThroughGoogle();
                    if(check == true)
                    {
                      // getxSignInScreenController.getUid();
                      Timer(Duration(seconds: 3), () {FireBaseHelper.fireBaseHelper.addAdmin();});
                      Shr.shr.setData(true);
                      getxSignInScreenController.checkCircularProgressIndicator.value = false;
                      Get.offAllNamed('/navagation');
                    }
                  },
                  child: Container(
                    height: 7.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 2)
                        ]
                    ),
                    child: Image.asset(getxSignInScreenController.googleButton),
                  ),
                ),
                Container(
                  height: 7.h,
                  width: 28.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 2)
                      ]
                  ),
                  alignment: Alignment.center,
                  child:Image.asset(getxSignInScreenController.appleButton,height: 3.h,),
                ),
                Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 2)
                      ]
                  ),
                  child: Image.asset(getxSignInScreenController.facebookButton),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0,80.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Get.offNamed('/register');
                    },
                    child: Text("if you don't have an account\nyou can Register here!",style: TextStyle(color: const Color(0xff4461F2),fontSize: 13.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center)),
              ],
            ),
          ),
          Transform.translate(
              offset: Offset(85.w, 5.h),
              child: Text("Jenil",style: GoogleFonts.babylonica(color: Colors.black12,fontSize: 18.sp,fontWeight: FontWeight.bold),)),
        ],
      ),
    ));
  }
  int i = 0;
  bool verified = false;
  void checkSignIn() {
    if(getxSignInScreenController.buttonData.value == "Tap To Continue")
    {
      i++;
      print('$i times Method Call');
      print("==================== Uid ${getxSignInScreenController.uid}");
      if(getxSignInScreenController.uid.value != "")
      {
        for(int i=0;i<getxSignInScreenController.adminDatas.length;i++)
        {
          if(getxSignInScreenController.adminDatas[i] == getxSignInScreenController.uid.value)
          {
            print("============================== Done");
            Shr.shr.setData(true);
            verified = true;
            getxSignInScreenController.checkCircularProgressIndicator.value = false;
            Get.offAllNamed('/navagation');
            i = 0;
            break;
          }
        }
        if(verified == false)
        {
          Get.snackbar("Ecommerce", "You Are Verified as an User.Create An Admin Account",onTap: (snack) {
            Get.toNamed('/register');
          },);
        }
      }
      else
      {
        if(i<100) {
          checkSignIn();
        }
      }
      // getxSignInScreenController.checkCircularProgressIndicator.value = false;
      // Get.offAllNamed('/navagation');
      // Get.
      // snack-bar("Done","Done");
    }
  }
}
