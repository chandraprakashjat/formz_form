import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../models/model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<EmailUnFocus>(_onEmailUnFocused);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordUnFocus>(_onPasswordUnFocus);
    on<SubmitButton>(_onSubmitButton);
  }

  FutureOr<void> _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    var emailAddress = event.emailAddress;

    final Email email = Email.dirty(emailAddress);

    emit(state.copyWith(
        email: email.valid ? email : Email.pure(emailAddress),
        formzStatus: Formz.validate([email, state.password])));
  }

  FutureOr<void> _onEmailUnFocused(
      EmailUnFocus event, Emitter<LoginState> emit) {
    Email email = Email.dirty(state.email.value);

    emit(state.copyWith(
        email: email, formzStatus: Formz.validate([email, state.password])));
  }

  FutureOr<void> _onPasswordChanged(
      PasswordChanged event, Emitter<LoginState> emit) {
    String pString = event.password;

    Password password = Password.dirty(pString);

    emit(state.copyWith(
        password: password.valid ? password : Password.pure(pString),
        formzStatus: Formz.validate([state.email, password])));
  }

  FutureOr<void> _onPasswordUnFocus(
      PasswordUnFocus event, Emitter<LoginState> emit) {
    Password password = Password.dirty(state.password.value);
    emit(state.copyWith(
        password: password,
        formzStatus: Formz.validate([state.email, password])));
  }

  FutureOr<void> _onSubmitButton(
      SubmitButton event, Emitter<LoginState> emit) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(
        email: email,
        password: password,
        formzStatus: Formz.validate([email, password])));

    if (state.formzStatus.isValid) {
      emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
      await Future.delayed(const Duration(seconds: 3));

      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
    }
  }
}
