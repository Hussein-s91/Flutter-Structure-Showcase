import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../utils/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value){
      Get.offAndToNamed(Routes.homePage);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Center(
          child: Lottie.asset('assets/lottie/intro.json'),
        ),
      ),
    );
  }
}
