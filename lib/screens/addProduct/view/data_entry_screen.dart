import 'package:ecommerce_admin_side/screens/addProduct/controller/addProductController.dart';
import 'package:ecommerce_admin_side/screens/addProduct/modal/add_product_modal.dart';
import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({super.key});

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  AddProductController getxAddProductController =
      Get.put(AddProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getxAddProductController.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    backgroundColor: Colors.black54,
                    title: "Add Category",
                    titleStyle: const TextStyle(color: Colors.white),
                    content: Column(
                      children: [
                        txtField("Category", getxAddProductController.txtAddCategory, 1),
                        Obx(
                          () =>  ElevatedButton(onPressed: () async {
                            if(getxAddProductController.txtAddCategory.text != "") {
                              getxAddProductController.checkAddCategory.value = await FireBaseHelper.fireBaseHelper.editCategory(category: getxAddProductController.txtAddCategory.text,list: getxAddProductController.cate.value);
                             // ignore: unrelated_type_equality_checks
                             if(getxAddProductController.checkAddCategory.value == true)
                               {
                                 Get.snackbar("Ecommerce", "Category Added",colorText: Colors.white);
                                 getxAddProductController.txtAddCategory.clear();
                                 getxAddProductController.getCategory();
                               }
                            }
                            else
                              {
                                Get.snackbar("Ecommerce", "Provide Category",colorText: Colors.white);
                              }
                          },
                              style: ElevatedButton.styleFrom(side: const BorderSide(color: Colors.white),backgroundColor: Colors.black),
                              child:  getxAddProductController.checkAddCategory.value==true?const Text("Add",style: TextStyle(color: Colors.white),):CircularProgressIndicator(color: Colors.white,)),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.add)),
          ],
          backgroundColor: Colors.transparent,
          title: const Text(
            "Add Data",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              txtField("Enter Product Name",
                  getxAddProductController.txtProductName, 1),
              txtField("Enter Product Price",
                  getxAddProductController.txtProductPrice, 1),
              txtField("Enter Product Discount",
                  getxAddProductController.txtProductDiscount, 1),
              txtField("Enter Product Discounted Price",
                  getxAddProductController.txtProductDiscountedPrice, 1),
              txtField("Enter Product Quantity",
                  getxAddProductController.txtProductQuantity, 1),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Obx(
                      () =>  DropdownMenu(
                        controller: getxAddProductController.txtProductCategory,
                          menuHeight: 140,
                          // width: 250,
                          // ignore: invalid_use_of_protected_member
                          label: getxAddProductController.menuItems.value.isEmpty? Text("Add Category",style: TextStyle(color: Colors.white,fontSize: 9.sp),): Text("Select Category",style: TextStyle(color: Colors.white,fontSize: 8.sp),),
                          trailingIcon: const Icon(Icons.arrow_drop_down_sharp,color: Colors.white,),
                          inputDecorationTheme: const InputDecorationTheme(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          textStyle: const TextStyle(color: Colors.white),
                          dropdownMenuEntries:
                          getxAddProductController.menuItems),
                    ),
                  ],
                ),
              ),
              txtField("Enter Product Company",
                  getxAddProductController.txtProductCompany, 1),
              txtField("Enter Product Category",
                  getxAddProductController.txtProductCategory, 1),
              txtField("Enter Product Description",
                  getxAddProductController.txtProductDescription, 5),
              txtField("Enter Product Image",
                  getxAddProductController.txtProductImage, 1),
              ElevatedButton(
                onPressed: () async {
                  if ((getxAddProductController.txtProductDiscount.text !=
                          "") &&
                      (getxAddProductController
                              .txtProductDiscountedPrice.text !=
                          "") &&
                      (getxAddProductController.txtProductPrice.text != "") &&
                      (getxAddProductController.txtProductPrice.text != "") &&
                      (getxAddProductController.txtProductName.text != "") &&
                      (getxAddProductController.txtProductDescription.text !=
                          "") &&
                      (getxAddProductController.txtProductCompany.text != "") &&
                      (getxAddProductController.txtProductCategory.text !=
                          "")) {
                    AddProductModal addProduct = AddProductModal(
                      productDiscount:
                          getxAddProductController.txtProductDiscount.text,
                      productDiscountedPrice: getxAddProductController
                          .txtProductDiscountedPrice.text,
                      productName: getxAddProductController.txtProductName.text,
                      productPrice:
                          getxAddProductController.txtProductPrice.text,
                      productQuantity:
                          getxAddProductController.txtProductQuantity.text,
                      productCategory:
                          getxAddProductController.txtProductCategory.text,
                      productCompany:
                          getxAddProductController.txtProductCompany.text,
                      productDescription:
                          getxAddProductController.txtProductDescription.text,
                      image: getxAddProductController.txtProductImage.text,
                    );
                    bool? check = await FireBaseHelper.fireBaseHelper
                        .addProduct(addProduct);
                    if (check == true) {
                      getxAddProductController.txtProductCategory.clear();
                      getxAddProductController.txtProductPrice.clear();
                      getxAddProductController.txtProductName.clear();
                      getxAddProductController.txtProductCompany.clear();
                      getxAddProductController.txtProductDiscountedPrice.clear();
                      getxAddProductController.txtProductQuantity.clear();
                      getxAddProductController.txtProductDescription.clear();
                      getxAddProductController.txtProductDiscount.clear();
                    }
                    {
                      Get.snackbar("Ecommerce", "Product Added",
                          colorText: Colors.white);
                    }
                  } else {
                    Get.snackbar("Ecommerce", "Provide All Data",
                        colorText: Colors.white);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    side: const BorderSide(color: Colors.white)),
                child: const Text("Add Product"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget txtField(String hintText, controller, int maxLines) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        maxLines: maxLines,
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white),
            hintText: hintText,
            border: const OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
/*
Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                child: TextField(
                  // controller: ,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter Product Name",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter Product Price",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Product Discount",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Product DiscountedPrice",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Product Total Quantity",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter Name of Company",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter Category",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Enter Description",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
 */
