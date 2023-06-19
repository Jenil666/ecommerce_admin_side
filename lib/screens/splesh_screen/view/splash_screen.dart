import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:ecommerce_admin_side/utils/shr_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../signIn/controller/signInScreenController.dart';

class SplaseScreen extends StatefulWidget {
  const SplaseScreen({super.key});

  @override
  State<SplaseScreen> createState() => _SplaseScreenState();
}

class _SplaseScreenState extends State<SplaseScreen> {
  bool? check;
  bool? check2;
  @override
  void initState() {
    SignInScreenController getxSignInScreenController = Get.put(SignInScreenController());
    super.initState();
    check = FireBaseHelper.fireBaseHelper.storeLogin();
    getData();
    getxSignInScreenController.getAdminData();
  }
  Future<void> getData()
  async {
    check2 = await Shr.shr.readData();
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),() {
      if(check == true && check2 == true) {
        Get.offNamed('/previewData');
      }
      else{
        Get.offNamed('/signIn');
      }
    },);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text("Jenil",style: GoogleFonts.babylonica(fontSize: 50.sp,color: Colors.white),),
        ),
      ),
    );
  }
}
