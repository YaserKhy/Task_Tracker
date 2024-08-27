import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {

  getWidth({double divideBy = 1}) {
    return MediaQuery.of(this).size.width / divideBy;
  }

  getHeight({double divideBy = 1}) {
    return MediaQuery.of(this).size.height / divideBy;
  }
}