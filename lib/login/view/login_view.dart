import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:formz_demo/login/bloc/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<LoginBloc>().add(EmailUnFocus());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      } else {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LoginBloc>().add(PasswordUnFocus());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: ((context, state) {
        if (state.formzStatus.isSubmissionInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Submitting...')));
        } else if (state.formzStatus.isSubmissionSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog(context: context, builder: (_) => const _SuccessDialog());
        }
      }),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmailInput(focusNode: _emailFocusNode),
            _PasswordInput(
              focusNode: _passwordFocusNode,
            ),
            _SubmitButton()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({required this.focusNode});
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        initialValue: state.email.value,
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: 'Email',
            icon: const Icon(Icons.mail),
            errorText: (state.email.invalid)
                ? "Please ensure the email entered is valid"
                : null,
            helperText: 'A complete valid email e.g abc@gmail.com'),
        onChanged: (value) =>
            context.read<LoginBloc>().add(EmailChanged(emailAddress: value)),
      );
    });
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({required this.focusNode});
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        initialValue: state.password.value,
        focusNode: focusNode,
        textInputAction: TextInputAction.done,
        obscureText: true,
        decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            labelText: 'Password',
            helperText:
                'Password should be at least 8 characters with at least one letter and number',
            helperMaxLines: 2,
            errorText: state.password.invalid
                ? 'Password must be at least 8 characters with at least one letter and number'
                : null,
            errorMaxLines: 2),
        onChanged: (value) =>
            context.read<LoginBloc>().add(PasswordChanged(password: value)),
      );
    });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: ((previous, current) =>
            previous.formzStatus != current.formzStatus),
        builder: (context, state) {
          return ElevatedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                context.read<LoginBloc>().add(SubmitButton());
              },
              child: const Text('Sumbit'));
        });
  }
}

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(Icons.info),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Submitted Successfully ',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('ok'))
          ],
        ),
      ),
    );
  }
}
