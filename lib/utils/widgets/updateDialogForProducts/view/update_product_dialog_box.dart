import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../screens/addedProductPreviewScree/modal/added_product_preview_modal.dart';
import '../controller/update_dialog_controller.dart';

class UpdateProductDialogBox extends StatelessWidget {
  // const UpdateProductDialogBox({super.key});
  UpdateDialogController getxUpdateDialogController = Get.put(UpdateDialogController());
  AddProductPreviewModal? data;
  UpdateProductDialogBox(this.data)
  {
    getxUpdateDialogController.txtImage = TextEditingController(text: "${data!.productImage}");
    getxUpdateDialogController.txtName = TextEditingController(text: "${data!.productName}");
    getxUpdateDialogController.txtUid = TextEditingController(text: "${data!.productId}");
    getxUpdateDialogController.txtDiscountedPrice = TextEditingController(text: "${data!.productDiscountedPrice}");
    getxUpdateDialogController.txtDiscount = TextEditingController(text: "${data!.productDiscount}");
    getxUpdateDialogController.txtPrice = TextEditingController(text: "${data!.productPrice}");
    getxUpdateDialogController.txtQuantity = TextEditingController(text: "${data!.productQuantity}");
    getxUpdateDialogController.txtDescription = TextEditingController(text: "${data!.productDescription}");
    getxUpdateDialogController.txtCompany = TextEditingController(text: "${data!.productCompany}");
    getxUpdateDialogController.txtCategory = TextEditingController(text: "${data!.productCategory}");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      width: 300,
      child: ListView(
        children: [
          updateTxtField("Enter Price",getxUpdateDialogController.txtPrice),
          updateTxtField("Enter Name",getxUpdateDialogController.txtName),
          updateTxtField("Enter Category",getxUpdateDialogController.txtCategory),
          updateTxtField("Enter Company",getxUpdateDialogController.txtCompany),
          updateTxtField("Enter Description",getxUpdateDialogController.txtDescription),
          updateTxtField("Enter Quantity",getxUpdateDialogController.txtQuantity),
          updateTxtField("Enter Discount",getxUpdateDialogController.txtDiscount),
          updateTxtField("Enter DiscountedPrice",getxUpdateDialogController.txtDiscountedPrice),
          // updateTxtField("Enter Uid",getxUpdateDialogController.txtUid),
          updateTxtField("Enter Image",getxUpdateDialogController.txtImage),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {
                AddProductPreviewModal UpdateData = AddProductPreviewModal(
                  productImage: getxUpdateDialogController.txtImage.text,
                  productId: getxUpdateDialogController.txtUid.text,
                  productDescription: getxUpdateDialogController.txtDescription.text,
                  productDiscount: getxUpdateDialogController.txtDiscount.text,
                  productDiscountedPrice: getxUpdateDialogController.txtDiscountedPrice.text,
                  productName: getxUpdateDialogController.txtName.text,
                  productPrice: getxUpdateDialogController.txtPrice.text,
                  productQuantity: getxUpdateDialogController.txtQuantity.text,
                  productCategory: getxUpdateDialogController.txtCategory.text,
                  productCompany: getxUpdateDialogController.txtCompany.text,
                );
                FireBaseHelper.fireBaseHelper.updateData(UpdateData);
              },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                  child: Text("Update")),
              ElevatedButton(onPressed: () {
                Get.back();
              },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                  child: Text("Cancle")),
            ],
          ),
        ],
      ),
    );
  }
  Widget updateTxtField(String hint,controller)
  {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "$hint",
          border: OutlineInputBorder(
            borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }
}
