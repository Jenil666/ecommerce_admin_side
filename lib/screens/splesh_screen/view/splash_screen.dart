import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SplaseScreen extends StatefulWidget {
  const SplaseScreen({super.key});

  @override
  State<SplaseScreen> createState() => _SplaseScreenState();
}

class _SplaseScreenState extends State<SplaseScreen> {
  bool? check;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check = FireBaseHelper.fireBaseHelper.storeLogin();
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),() {
      if(check == true) {
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
