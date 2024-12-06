import 'package:date_ai/screens/app_shell.dart';
import 'package:date_ai/services/login_service.dart';
import 'package:date_ai/services/secure_storage_service.dart';
import 'package:date_ai/utils/input_validator.dart';
import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/widgets/error_text.dart';
import 'package:date_ai/widgets/inputfield/custom_textfield.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _inputValidator = InputValidator();
  final loginService = LoginService();
  final _secureStorageService = SecureStorageService();
  late Map<String, String> data;
  bool _loading = false;
  String? _error;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = {
      'email': '',
      'password': ''
    };
  }

  void _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    String? error;

    try {
      var response = await loginService.execute(data);

      if (response.success) {
        await _secureStorageService.writeData(
            'token',
            response.data['accessToken']
        );
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AppShell(),
            ),
            ModalRoute.withName("/Home")
        );
      } else {
        print(response.error);
        error = 'Invalid credentials';
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                    'Login',
                    textAlign: TextAlign.center,
                    style: themeHelper.textStyle.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.05,),
                  showError(context, _error),
                  SizedBox(height: screenSize.height * 0.03),
                  CustomTextFiled(
                    key: const Key('loginScreenEmail'),
                    context: context,
                    validator: _inputValidator.validateEmail,
                    onSaved: (String? value){data['email'] = value ?? '';},
                    labelText: 'Email',
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  CustomTextFiled(
                    key: const Key('loginScreenPassword'),
                    context: context,
                    onSaved: (String? value){data['password'] = value ?? '';},
                    validator: _inputValidator.validatePassword,
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
                    key: const Key('loginScreenSubmit'),
                    onPressed:  _loading ? null : ()
                        {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _login();
                          }
                        },
                    context: context,
                    child: _loading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: themeHelper.colorScheme.onPrimary,
                            ),
                         )
                        : Text(
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
      ),
    );
  }
}
