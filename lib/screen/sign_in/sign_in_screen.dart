import 'package:flutter/material.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/screen/sign_in/components/body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static String routeName = "/login_page";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(toolbarHeight: 10),
      body: const Body(),
    );
  }
}
