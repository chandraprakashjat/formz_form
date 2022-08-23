part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> props() => [];
}

class EmailChanged extends LoginEvent {
  const EmailChanged({required this.emailAddress});

  final String emailAddress;

  @override
  List<Object?> props() => [emailAddress];
}

class EmailUnFocus extends LoginEvent {}

class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.password});
  final String password;

  @override
  List<Object?> props() => [password];
}

class PasswordUnFocus extends LoginEvent {}

class SubmitButton extends LoginEvent {}
