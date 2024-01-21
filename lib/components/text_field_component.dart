import 'package:code_structure_showcase/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/theme_text.dart';

class TextFieldComponent extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeHolder;
  final void Function(String)? onChanged;
  final void Function()? onSuffixIconTap;

  TextFieldComponent({Key? key, this.controller, this.placeHolder = '', this.onChanged, this.onSuffixIconTap}) : super(key: key);

   final Color backgroundColor = Colours.tertiary.withOpacity(0.3);
   final Color textColor = Colours.tertiary;


  @override
  Widget build(BuildContext context) {

    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: backgroundColor)
    );

    return SizedBox(
      height: ScreenUtil().setHeight(48),
      child: TextField(
        controller: controller,
        cursorColor: textColor,
        style: ThemeText.subtitle.copyWith(color: textColor),
        onChanged: onChanged,
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Icon(Icons.search, color: textColor,),
            ),
            suffixIcon: GestureDetector(
              onTap: onSuffixIconTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Icon(Icons.close, color: textColor,),
              ),
            ),
            hintText: placeHolder,
            hintStyle: ThemeText.placeholder.copyWith(color: textColor, height: 1.5),
            filled: true,
            fillColor: backgroundColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            border: outlineInputBorder,
            errorBorder: outlineInputBorder,
            disabledBorder: outlineInputBorder
        ),
      ),
    );
  }
}
