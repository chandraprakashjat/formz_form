import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz_demo/app.dart';
import 'package:formz_demo/bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}
