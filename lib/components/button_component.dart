import 'package:code_structure_showcase/theme/colours.dart';
import '../theme/theme_text.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const ButtonComponent({
    Key? key,
    this.onTap,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.all(10.0),
        height: 45,
        width: 250,
        decoration: BoxDecoration(
            color: Colours.tertiary,
            borderRadius: BorderRadius.circular(borderRadius)
        ),
        child: Center(child: Text(text, style: ThemeText.subtitle.copyWith(color: Colors.white, height: 1.5),)),
      ),
    );
  }
}
