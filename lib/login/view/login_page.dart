import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz_demo/login/bloc/login_bloc.dart';

import '../login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);

        if (!focusScopeNode.hasPrimaryFocus) {
          focusScopeNode.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
              title: Text(
            'Login Formz',
            style: textTheme.bodyText1,
          )),
          body: BlocProvider(
            create: (_) => LoginBloc(),
            child: const LoginView(),
          )),
    );
  }
}
