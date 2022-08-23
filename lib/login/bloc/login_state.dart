part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.formzStatus = FormzStatus.pure});

  final Email email;
  final Password password;
  final FormzStatus formzStatus;

  LoginState copyWith(
      {Email? email, Password? password, FormzStatus? formzStatus}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formzStatus: formzStatus ?? this.formzStatus);
  }

  @override
  List<Object> props() => [email, password, formzStatus];
}
