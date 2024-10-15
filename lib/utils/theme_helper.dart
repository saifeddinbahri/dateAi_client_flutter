import 'package:flutter/material.dart';

class ThemeHelper {
  final BuildContext context;
  ThemeHelper(this.context);

  TextTheme get textStyle => Theme.of(context).textTheme;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;
}