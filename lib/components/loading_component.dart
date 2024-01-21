import 'package:code_structure_showcase/theme/colours.dart';
import 'package:flutter/cupertino.dart';

class LoadingComponent extends StatelessWidget {
  final Color? color;
  const LoadingComponent({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(color: color??Colours.tertiary,);
  }
}
