import 'package:formz/formz.dart';

// Define input validation errors
enum ConfirmPasswordError { empty, length, format, mismatch }

// Extend FormzInput and provide the input type and error type.
class ConfirmPassword extends FormzInput<String, ConfirmPasswordError> {
  final String password;

  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ConfirmPassword.dirty({String value = '', required this.password})
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ConfirmPasswordError.empty) {
      return 'El campo es requerido';
    }
    if (displayError == ConfirmPasswordError.length) {
      return 'Mínimo 6 caracteres';
    }
    if (displayError == ConfirmPasswordError.format) {
      return 'Debe de tener Mayúscula, letras y un número';
    }
    if (displayError == ConfirmPasswordError.mismatch) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ConfirmPasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return ConfirmPasswordError.empty;
    }
    if (value.length < 6) return ConfirmPasswordError.length;
    if (!passwordRegExp.hasMatch(value)) return ConfirmPasswordError.format;
    if (value != password) return ConfirmPasswordError.mismatch;

    return null;
  }
}
