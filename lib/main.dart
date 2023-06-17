import 'package:ecommerce_admin_side/screens/addProduct/view/data_entry_screen.dart';
import 'package:ecommerce_admin_side/screens/addProduct/view/edit_category_screen.dart';
import 'package:ecommerce_admin_side/screens/addedProductPreviewScree/view/added_product_preview_screen.dart';
import 'package:ecommerce_admin_side/screens/register/view/register_screen.dart';
import 'package:ecommerce_admin_side/screens/sendNotificationScreen/view/send_notification_screen.dart';
import 'package:ecommerce_admin_side/screens/signIn/view/sign_in_screen.dart';
import 'package:ecommerce_admin_side/screens/splesh_screen/view/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(
      builder:(context, orientation, deviceType) =>  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/notification',
        getPages: [
          GetPage(name: '/', page: () => const SplaseScreen(),),
          GetPage(name: '/signIn', page: () => const SignInScreen(),),
          GetPage(name: '/register', page: () => const RegisterScreen(),),
          GetPage(name: '/dataEntry', page: () => const DataEntryScreen(),),
          GetPage(name: '/previewData', page: () => const AddedProductPreviewScreen(),),
          GetPage(name: '/notification', page: () => const SendNotificationScreen(),),
          GetPage(name: '/category', page: () => const EditCategoryScreen(),),
        ],
      ),
    ),
  );
}
