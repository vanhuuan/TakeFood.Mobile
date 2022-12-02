
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/small_text.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = "Error",bool type=true}) {
  Get.snackbar(title, message,
      titleText: SmallText(
        text: title,
        color: Colors.white,
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: type?Colors.redAccent:Colors.blueAccent,
      onTap: (snack){

      }
  );
}