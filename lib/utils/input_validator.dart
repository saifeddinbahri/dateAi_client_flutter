import 'package:email_validator/email_validator.dart';

class InputValidator {

  final _emptyStringError = 'Please fill this field';

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return _emptyStringError;
    } else if (EmailValidator.validate(email)) {
      return null;
    }
    return 'Invalid email';
  }

  String? validateUsername(String? name) {
    if (name == null || name.isEmpty) {
      return _emptyStringError;
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return _emptyStringError;
    } else if (password.length < 8) {
      return "Password can't be less than 8 characters";
    }
    return null;
  }

}