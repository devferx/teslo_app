import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teslo_shop/features/shared/shared.dart';

part 'register_form_provider.g.dart';

class RegisterFormState {
  final FullName fullName;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;

  RegisterFormState({
    this.fullName = const FullName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
  });

  RegisterFormState copyWith({
    FullName? fullName,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
  }) =>
      RegisterFormState(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
      );

  @override
  String toString() {
    return '''
    RegisterFormState:
      fullName: $fullName,
      email: $email,
      password: $password,
      confirmPassword: $confirmPassword,
      isPosting: $isPosting,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
    ''';
  }
}

@riverpod
class RegisterForm extends _$RegisterForm {
  @override
  RegisterFormState build() {
    return RegisterFormState();
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    await Future.delayed(Duration(seconds: 2));

    state = state.copyWith(isPosting: false, isFormPosted: true);
  }

  _touchEveryField() {
    state = state.copyWith(
      isFormPosted: true,
      isValid: Formz.validate([
        FullName.dirty(state.fullName.value),
        Email.dirty(state.email.value),
        Password.dirty(state.password.value),
        ConfirmPassword.dirty(
          value: state.confirmPassword.value,
          password: state.password.value,
        ),
      ]),
    );
  }

  onFullNameChanged(String value) {
    state = state.copyWith(
      fullName: FullName.dirty(value),
      isValid: Formz.validate([
        FullName.dirty(value),
        Email.dirty(state.email.value),
        Password.dirty(state.password.value),
      ]),
    );
  }

  onEmailChanged(String value) {
    state = state.copyWith(
      email: Email.dirty(value),
      isValid: Formz.validate([
        Email.dirty(value),
        FullName.dirty(state.fullName.value),
        Password.dirty(state.password.value),
      ]),
    );
  }

  onPasswordChanged(String value) {
    state = state.copyWith(
      password: Password.dirty(value),
      isValid: Formz.validate([
        Password.dirty(value),
        FullName.dirty(state.fullName.value),
        Email.dirty(state.email.value),
      ]),
    );
  }

  onConfirmPasswordChanged(String value) {
    state = state.copyWith(
      confirmPassword:
          ConfirmPassword.dirty(value: value, password: state.password.value),
      isValid: Formz.validate([
        ConfirmPassword.dirty(value: value, password: state.password.value),
        FullName.dirty(state.fullName.value),
        Email.dirty(state.email.value),
        Password.dirty(state.password.value),
      ]),
    );
  }
}
