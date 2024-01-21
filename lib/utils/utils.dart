import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Utils{
  static String errorMsg = 'Ops, something went wrong. Please try again.';

  static const BoxShadow boxShadow = BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 2), spreadRadius: 0, blurRadius: 10);

  static const double _designHeight = 812; // The design height than I am working on
  static const double _designWidth = 375; // The design width that I am working on

  // Calculation to transform design height (in our case: 812) to the actual screen height
  static double height(double componentHeight){
    return (1.sh - ScreenUtil().statusBarHeight)*componentHeight/_designHeight;
  }

  // Calculation to transform design width (in our case: 375) to the actual screen width
  static double width(double componentWidth){
    return 1.sw*componentWidth/_designWidth;
  }

}