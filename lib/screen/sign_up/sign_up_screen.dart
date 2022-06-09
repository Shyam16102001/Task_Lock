import 'package:flutter/material.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/screen/sign_up/components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: const Body(),
    );
  }
}
