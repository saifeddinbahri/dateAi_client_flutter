import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/widgets/inputfield/cusotm_textfield.dart';
import 'package:flutter/material.dart';

import '../../utils/theme_helper.dart';
import '../../widgets/buttons/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final screenPadding = ScreenPadding(context);
    final screenSize = ScreenSize(context);
    final themeHelper = ThemeHelper(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenPadding.horizontal
        ),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenSize.height * 0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.05,),
                Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: themeHelper.textStyle.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: screenSize.height * 0.05,),
                CustomTextFiled(
                  context: context,
                  labelText: 'Email',
                ),
                SizedBox(height: screenSize.height * 0.03),
                CustomTextFiled(
                  context: context,
                  labelText: 'Password',
                  obscureText: _hidePassword,
                ),
                SizedBox(height: screenSize.height * 0.05),
                PrimaryButton(
                  onPressed: (){},
                  context: context,
                  child: Text(
                    'Sign Up',
                    style: themeHelper.textStyle.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
