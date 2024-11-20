import 'package:flutter/material.dart';

class CustomTextFiled extends TextFormField {
  CustomTextFiled({
   super.key,
   super.focusNode,
   super.controller,
   String? labelText,
   Widget? icon,
   super.obscureText,
   super.validator,
   required BuildContext context,
   super.onSaved,
}): super(
   decoration: InputDecoration(
     enabledBorder: OutlineInputBorder(
         borderSide: BorderSide(
             color: Theme.of(context).colorScheme.outlineVariant
         )
     ),
     focusedBorder: OutlineInputBorder(
       borderSide: BorderSide(
         color: Theme.of(context).colorScheme.outline,
         width: 2,
       ),
     ),
     errorBorder: OutlineInputBorder(
         borderSide: BorderSide(
             color: Theme.of(context).colorScheme.error
         )
     ),
     focusedErrorBorder: OutlineInputBorder(
         borderSide: BorderSide(
             color: Theme.of(context).colorScheme.error
         )
     ),
     labelText: labelText,
     labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
         color: Colors.black54
     ),
   ),
  );
}