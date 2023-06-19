import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/fire_base_helper.dart';
import '../controller/addProductController.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({super.key});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
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
    print(getxAddProductController.cate.length);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF7F6F4),
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text("Edit Category2"),
        ),
        body: StreamBuilder(
          stream: FireBaseHelper.fireBaseHelper.readCategoryDataToDisplay(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
            {
              String id = "";
              RxList data = [].obs;
              QuerySnapshot? snapData = snapshot.data;
              for (var x in snapData!.docs) {
                Map? entry = x.data() as Map?;
                id = x.id;
                data.value = entry!['data'];
              }

              return Obx(
                () => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () {
                        getxAddProductController.txtUpdateSingleCategory = TextEditingController(text: "${data[index]}");
                        Get.defaultDialog(
                          title: "Update",
                          content: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                                ),
                                child: TextField(
                                  controller: getxAddProductController.txtUpdateSingleCategory,
                                  decoration: InputDecoration(
                                    hintText: "Enter Category",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              ElevatedButton(onPressed: () {
                                data[index] = getxAddProductController.txtUpdateSingleCategory.text;
                                FireBaseHelper.fireBaseHelper.editCategory(list: data);
                              }, child: Text("Update")),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xdbe5e5e5),

                          // border: Border.all(color: Colors.black)
                    ),
                        child: Obx(
                          () => ListTile(
                            title: Text("${data[index]}"),
                            trailing: getxAddProductController.checkAddCategory == true
                                    ? IconButton(
                                        onPressed: () {
                                          data.removeAt(index);
                                          FireBaseHelper.fireBaseHelper.editCategory(list: data);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                    : CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
