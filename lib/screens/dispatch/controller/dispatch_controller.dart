import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_side/screens/dispatch/modal/dispatch_modal.dart';
import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:get/get.dart';

class DispatchController extends GetxController
{
  RxList<DispatchModal> orderData = <DispatchModal>[].obs;
  List productsId = [];
  var data;
  Future<void> getDispatchData()
  async {
    QuerySnapshot? querySnapshort = await FireBaseHelper.fireBaseHelper.readDispatchData();
    var mapData = querySnapshort.docs;
    productsId.clear();
    for(int i =0;i<mapData.length;i++)
      {
        productsId.add(mapData[i]['productId']);
      }
    orderData.clear();
    for(int i = 0;i<productsId.length;i++)
      {
        QuerySnapshot? dispatched =await FireBaseHelper.fireBaseHelper.readDataFromId(id: productsId[i]);
        data = dispatched.docs;
        DispatchModal p1 = DispatchModal(
          productId: data[0].id,
          productCompany: data[0]['Company'],
          productCategory: data[0]['Catedory'],
          productQuantity: data[0]['Quantity'],
          productPrice: data[0]['Price'],
          productName: data[0]['Name'],
          productDiscountedPrice: data[0]['Discounted Price'],
          productDiscount: data[0]['Discount'],
          productDescription: data[0]['Description'],
          productImage: data[0]['image'],
        );
        orderData.add(p1);
      }
  }
}