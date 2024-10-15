import 'package:flutter/cupertino.dart';

class ScreenPadding {
  final BuildContext context;

  ScreenPadding(this.context);

  double get horizontal => MediaQuery.of(context).size.width * 0.04;
}