import 'package:flutter/material.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/screen/add_task/add_task_screen.dart';
import 'package:task_lock/screen/home_page/components/body.dart';
import 'package:task_lock/screen/profile/profile_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static String routeName = "/home_page";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Task Lock",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .merge(const TextStyle(color: kTextColor)),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      ProfileScreen.routeName,
                      ModalRoute.withName(HomePage.routeName));
                },
                icon: const Icon(Icons.account_circle))
          ],
        ),
        body: const Body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AddTaskScreen.routeName, ModalRoute.withName(HomePage.routeName)),
          tooltip: 'It helps to add a new Task',
          backgroundColor: kSecondaryColor,
          child: const Icon(Icons.add, color: kBackgroundColor),
        ));
  }
}
