import 'package:flutter/material.dart';
import '../utils/theme_helper.dart';

Widget showError(BuildContext context,String? error) {
  final theme = ThemeHelper(context);
  if (error != null) {
    return Text(
      error!,
      textAlign: TextAlign.center,
      style: theme.textStyle.bodyMedium!.copyWith(
          color: theme.colorScheme.error
      ),
    );
  }
  return const SizedBox();
}