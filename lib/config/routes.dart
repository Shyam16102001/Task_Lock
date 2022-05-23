import 'package:flutter/material.dart';
import 'package:task_lock/components/checking.dart';
import 'package:task_lock/screen/add_task/add_task_screen.dart';
import 'package:task_lock/screen/home_page/home_page.dart';
import 'package:task_lock/screen/sign_in/sign_in_screen.dart';
import 'package:task_lock/screen/sign_up/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Checking.routeName: (context) => const Checking(),
  HomePage.routeName: (context) => const HomePage(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  AddTaskScreen.routeName: (context) => const AddTaskScreen(),

  // PetsDetailScreen.routeName: (context) =>  PetsDetailScreen(),
  // NoInternetScreen.routeName: (context) => NoInternetScreen(),
};
