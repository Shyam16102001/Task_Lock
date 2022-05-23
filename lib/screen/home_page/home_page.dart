import 'package:flutter/material.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/screen/home_page/components/body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static String routeName = "/home_page";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Body();
  }
}
