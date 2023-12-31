import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPreviewController extends GetxController
{
  RxInt index = 0.obs;
  List name = [
    "Notification",
    "Add Data",
    "Category",
    "Orders",
    "Dispatched",
  ];
  List<dynamic> icon = [
   Icons.messenger,
   Icons.add,
   Icons.category,
   Icons.remove_from_queue_sharp,
   Icons.move_down
  ];
  List navagtin = [
    '/notification',
    '/dataEntry',
    '/category',
    '/order',
    '/dispatch',
  ];
}