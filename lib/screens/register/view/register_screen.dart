import 'package:ecommerce_admin_side/screens/register/controller/registerScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/fire_base_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
RegisterScreenController getxRegisterScreenController =Get.put(RegisterScreenController());
class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: 100.h,
              width: 100.w,
              child: Image.asset(
                getxRegisterScreenController.backGround,
                fit: BoxFit.cover,
              ),
            ),
            Transform.translate(
                offset: Offset(0, 24.h),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Create Account As Admin",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: Colors.black),
                    ))),
            Transform.translate(
              offset: Offset(0, 34.h),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 7.h,
                width: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: getxRegisterScreenController.txtEmail,
                    style: const TextStyle(color: Color(0xff667085)),
                    cursorColor: const Color(0xff667085),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            getxRegisterScreenController.txtEmail.clear();
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Color(0xff667085),
                            size: 20,
                          ),
                        ),
                        hintText: "Enter Email",
                        hintStyle: const TextStyle(color: Color(0xff4F555A)),
                        border:
                        const UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 43.5.h),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 7.h,
                width: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                        () => TextField(
                      enableSuggestions: true,
                      // ignore: unrelated_type_equality_checks
                      obscureText: getxRegisterScreenController.showPassword == true
                          ? false
                          : true,
                      controller: getxRegisterScreenController.txtPassword,
                      style: const TextStyle(color: Color(0xff667085)),
                      cursorColor: const Color(0xff667085),
                      decoration: InputDecoration(
                          suffixIcon: Obx(
                                () => IconButton(
                              onPressed: () {
                                getxRegisterScreenController
                                    .showPassword.value =
                                !getxRegisterScreenController
                                    .showPassword.value;
                              },
                              icon: Icon(
                                // ignore: unrelated_type_equality_checks
                                getxRegisterScreenController.showPassword ==
                                    false
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xff667085),
                                size: 20,
                              ),
                            ),
                          ),
                          hintText: "Enter Password",
                          hintStyle: const TextStyle(color: Color(0xff4F555A)),
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 57.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Obx(
                      () =>  InkWell(
                    onTap: () async {
                      
                      getxRegisterScreenController.chechCircularProgressIndicator.value = true;
                      bool? check;
                      if(getxRegisterScreenController.buttonText.value == "Tap To Continue")
                      {
                        // getxRegisterScreenController.checkCircularProgressIndicator.value = false;
                        Get.offAllNamed("/dataEntry");
                        Get.snackbar("Jenil", "Login SuccessFully",colorText: Colors.white);
                      }
                      if((getxRegisterScreenController.txtPassword.text == "") && (getxRegisterScreenController.txtEmail.text == ""))
                      {
                        getxRegisterScreenController.chechCircularProgressIndicator.value = false;
                        Get.snackbar("Jenil", "Provide proper email and password");
                      }
                      else
                      {
                        check = await FireBaseHelper.fireBaseHelper.createAccount(email: getxRegisterScreenController.txtEmail.text,password: getxRegisterScreenController.txtPassword.text);
                        if(check == false && (getxRegisterScreenController.buttonText.value != "Tap To Continue"))
                        {
                          getxRegisterScreenController.chechCircularProgressIndicator.value = false;
                          Get.snackbar("Jenil", 'Try with another username');
                        }
                        else if(check == true)
                        {
                          getxRegisterScreenController.chechCircularProgressIndicator.value = false;
                          // getxRegisterScreenController.buttonText.value = ""
                          Get.snackbar("Jenil", "Account Created");
                          // Get.toNamed("/signIn");
                          getxRegisterScreenController.buttonText.value = "Tap To Continue";
                        }
                      }
                    },
                    child: Container(
                      height: 7.h,
                      width: 100.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color(0xff4461F2),
                          borderRadius: BorderRadius.circular(10)),
                      child: getxRegisterScreenController.chechCircularProgressIndicator.value==false?Text(
                        getxRegisterScreenController.buttonText.value,
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ):const CircularProgressIndicator(color: Colors.white,),
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 80.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.offNamed('/signIn');
                      },
                      child: Text(
                          "Already have an account\nyou can sign in here!",
                          style: TextStyle(
                              color: const Color(0xff4461F2),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center)),
                ],
              ),
            ),
            Transform.translate(
                offset: Offset(85.w, 5.h),
                child: Text("Jenil",style: GoogleFonts.babylonica(color: Colors.black12,fontSize: 18.sp,fontWeight: FontWeight.bold),)),
          ],
        )
      ),
    );
  }
}
