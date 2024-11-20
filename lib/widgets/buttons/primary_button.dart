import 'package:flutter/material.dart';

class PrimaryButton extends TextButton {
  PrimaryButton({
    super.key,
    required super.child,
    required super.onPressed,
    super.onLongPress,
    super.onFocusChange,
    Color? bgColor,
    required BuildContext context,
  }): super(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
      backgroundColor: bgColor ?? Theme.of(context).colorScheme.primary,
    )
  );
}