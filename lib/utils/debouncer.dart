import 'dart:async';
import 'package:flutter/cupertino.dart';

class DeBouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DeBouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}