import 'package:code_structure_showcase/theme/colours.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../utils/routes.dart';
import '../utils/utils.dart';

showError({void Function()? onPressed}){
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: const Text('Error'),
        content: Text(Utils.errorMsg),
        actions: [
          TextButton(
            onPressed: (){
              Get.back();
              if(onPressed != null){
                onPressed();
              }
            },
            child: const Text("Retry", style: TextStyle(color: Colours.tertiary),),
          ),

          if(Get.currentRoute != Routes.homePage)
          TextButton(
            onPressed: (){
              Get.back();
              Get.back();
            },
            child: const Text("Go home", style: TextStyle(color: Colours.tertiary),),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}