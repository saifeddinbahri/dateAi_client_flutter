import 'package:date_ai/services/signup_service.dart';
import 'package:date_ai/utils/input_validator.dart';
import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/widgets/inputfield/cusotm_textfield.dart';
import 'package:flutter/material.dart';

import '../../utils/theme_helper.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/error_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _hidePassword = true;
  final inputValidator = InputValidator();
  final signupService = SignupService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _error;
  late Map<String, String> data ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = {
      'name': '',
      'email':'',
      'password':'',
    };
  }

  void _register() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    String? error;

    try {
      var response = await signupService.execute(data);

      if (!mounted) return;

      if (response.success) {
        Navigator.pop(context);
      } else {
        print(response.error);
        error = 'Something went wrong, please try again.';
      }
    } catch(e) {
      print(e);
      error = 'Something went wrong, please try again.';
    }
    setState(() {
      _loading = false;
      _error = error;
    });
  }

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
            key: _formKey,
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
                showError(context, _error),
                SizedBox(height: screenSize.height * 0.03),
                CustomTextFiled(
                  onSaved: (String? value){data['name'] = value ?? '';},
                  validator: inputValidator.validateUsername,
                  context: context,
                  labelText: 'Username',
                ),
                SizedBox(height: screenSize.height * 0.03),
                CustomTextFiled(
                  onSaved: (String? value){data['email'] = value ?? '';},
                  validator: inputValidator.validateEmail,
                  context: context,
                  labelText: 'Email',
                ),
                SizedBox(height: screenSize.height * 0.03),
                CustomTextFiled(
                  onSaved: (String? value){data['password'] = value ?? '';},
                  validator: inputValidator.validatePassword,
                  context: context,
                  labelText: 'Password',
                  obscureText: _hidePassword,
                ),
                SizedBox(height: screenSize.height * 0.05),
                PrimaryButton(
                  onPressed: _loading ? null : (){
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _register();
                    }
                  },
                  context: context,
                  child: _loading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                              color: themeHelper.colorScheme.onPrimary,
                            ),
                      )
                      : Text(
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
