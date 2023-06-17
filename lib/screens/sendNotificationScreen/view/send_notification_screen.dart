import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_side/screens/sendNotificationScreen/modal/send_notification_modal.dart';
import 'package:ecommerce_admin_side/utils/api_helper.dart';
import 'package:ecommerce_admin_side/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/send_notification_screen_controller.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    SendNotificationScreenController getxSendNotificationScreenController = Get.put(SendNotificationScreenController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Send Notification"),
        ),
        body: StreamBuilder(
          stream: FireBaseHelper.fireBaseHelper.readUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              List<SendNotificationModal> data = [];
              QuerySnapshot? snapData = snapshot.data;
              data.clear();
              for (var x in snapData!.docs) {
                Map user = x.data() as Map;
                String name = user['Name'];
                String email = user['Email'];
                String fmcToken = user['FmcToken'];
                String mobileNumber = user['Mobile Number'];
                String address = user['Address'];

                SendNotificationModal t1 = SendNotificationModal(
                  fmcToken: fmcToken,
                  address: address,
                  email: email,
                  name: name,
                  number: mobileNumber,
                );
                data.add(t1);
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return   InkWell(
                      onLongPress: () {
                        getxSendNotificationScreenController.selectedContainerFmcToken = data[index].fmcToken;
                        Get.defaultDialog(
                          title: "Message",
                          content: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: TextField(
                                  controller: getxSendNotificationScreenController.txtTitle,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Title",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                      )
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: TextField(
                                  controller: getxSendNotificationScreenController.txtBody,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Body",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                      )
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              ElevatedButton(onPressed: () {
                                if((getxSendNotificationScreenController.txtTitle.text!="") && (getxSendNotificationScreenController.txtBody.text!=""))
                                  {
                                    Get.back();
                                    ApiHelper.apiHelper.postApi(getxSendNotificationScreenController.selectedContainerFmcToken, getxSendNotificationScreenController.txtTitle.text, getxSendNotificationScreenController.txtBody.text);
                                    Get.snackbar("Ecommerce", "Notification Send");
                                    getxSendNotificationScreenController.txtTitle.clear();
                                    getxSendNotificationScreenController.txtBody.clear();
                                  }
                                else if((getxSendNotificationScreenController.txtTitle.text == "") && (getxSendNotificationScreenController.txtBody.text != ""))
                                  {
                                    Get.snackbar("Ecommerce", "Provide Title");
                                  }
                                else if((getxSendNotificationScreenController.txtTitle.text != "") && (getxSendNotificationScreenController.txtBody.text == ""))
                                {
                                  Get.snackbar("Ecommerce", "Provide Body");
                                }
                                else if((getxSendNotificationScreenController.txtTitle.text == "") && (getxSendNotificationScreenController.txtBody.text == ""))
                                {
                                  Get.snackbar("Ecommerce", "Provide Title & Body");
                                }
                              }, child: const Text("Send"),),
                            ],
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text("${data[index].name}"),
                        subtitle: Text("${data[index].email}"),
                      ),
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
