import 'package:formz/formz.dart';

enum PasswordValidationError {
  invalidPassword
} // Create seprate error according requirement

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([super.value = '']) : super.pure();
  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'); // Replace with your Password Regex
  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegex.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalidPassword;
  }
}
