import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_side/screens/addedProductPreviewScree/modal/added_product_preview_modal.dart';
import 'package:ecommerce_admin_side/utils/api_helper.dart';
import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/widgets/updateDialogForProducts/view/update_product_dialog_box.dart';

class AddedProductPreviewScreen extends StatefulWidget {
  const AddedProductPreviewScreen({super.key});

  @override
  State<AddedProductPreviewScreen> createState() =>
      _AddedProductPreviewScreenState();
}

class _AddedProductPreviewScreenState extends State<AddedProductPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Product Preview"),),
        body: StreamBuilder(stream: FireBaseHelper.fireBaseHelper.readAdminAddedData(),builder: (context, snapshot) {
          if(snapshot.hasError)
            {
              return Center(
                child: Text("${snapshot.error}",style: TextStyle(color: Colors.black),),
              );
            }
          else if(snapshot.hasData)
            {
              print("=====================Has Data");
              List<AddProductPreviewModal> listData = [];
              QuerySnapshot? snapData = snapshot.data;
              // print(snapData);
              for(var x in snapData!.docs)
                {
                  print("Done =====================????/");
                  Map? data = x.data() as Map;

                  AddProductPreviewModal p1 = AddProductPreviewModal(
                    productCompany: data['Company'],
                    productCategory: data['Catedory'],
                    productQuantity: data['Quantity'],
                    productPrice: data['Price'],
                    productName: data['Name'],
                    productDiscountedPrice:  data['Discounted Price'],
                    productDiscount: data['Discount'],
                    productDescription: data['Description'],
                    productId: x.id,
                    productImage: data['image'],
                  );
                  listData.add(p1);
                  print("Name ============ ${data['Name']}");
                }
              return ListView.builder(itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${listData[index].productName}",style: TextStyle(color: Colors.black),),
                  subtitle: Text("${listData[index].productPrice}",style: TextStyle(color: Colors.black)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {
                        FireBaseHelper.fireBaseHelper.delete(listData[index].productId);
                      }, icon: Icon(Icons.delete,color: Colors.red,)),
                      IconButton(onPressed: () {
                        Get.defaultDialog(title: "Update",content: UpdateProductDialogBox(listData[index]));
                      }, icon: Icon(Icons.edit,color: Colors.amber,))
                    ],
                  ),
                );
              },itemCount: listData.length,);
            }
          return Center(child: CircularProgressIndicator(),);
        },),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 6.h),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 4.h,
                    ),
                  ],
                ),
                ElevatedButton(onPressed: () {
                  // ApiHelper.apiHelper.postApi();
                  Get.toNamed('notification');
                }, child: Text("Send message")),
                ElevatedButton(onPressed: () {
                  // ApiHelper.apiHelper.postApi();
                  Get.toNamed('dataEntry');
                }, child: Text("Add data")),
                ElevatedButton(onPressed: () {
                  // ApiHelper.apiHelper.postApi();
                  Get.toNamed('/category');
                }, child: Text("Edit Category")),
                ElevatedButton( onPressed: () async {
                  bool? check = await FireBaseHelper.fireBaseHelper.signOut();
                  if (check == true) {
                    Get.offNamed("/signIn");
                  }
                }, child: Text("Sign Out")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
