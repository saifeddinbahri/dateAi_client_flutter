import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/widgets/inputfield/cusotm_textfield.dart';
import 'package:flutter/material.dart';

import '../../utils/theme_helper.dart';
import '../../widgets/buttons/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  'Login',
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
                SizedBox(height: screenSize.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: themeHelper.textStyle.titleSmall!.copyWith(
                          color: themeHelper.colorScheme.secondary
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.02),
                PrimaryButton(
                  onPressed: (){},
                  context: context,
                  child: Text(
                    'Log in',
                    style: themeHelper.textStyle.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                Text(
                  'OR',
                  style: themeHelper.textStyle.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenSize.height * 0.03),
                PrimaryButton(
                    context: context,
                    onPressed: (){},
                    bgColor: themeHelper.colorScheme.secondaryContainer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/icons/google_G_logo.png'),
                          width: 22,
                          height: 22,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: screenSize.width * 0.02,),
                        Text(
                          'Continue with google',
                          style: themeHelper.textStyle.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onSecondaryContainer
                          ),
                        )
                      ],
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
