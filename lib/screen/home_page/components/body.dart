import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/data_service/auth/log_out.dart';
import 'package:task_lock/screen/add_task/add_task_screen.dart';
import 'package:task_lock/screen/home_page/home_page.dart';
import 'package:task_lock/screen/sign_in/sign_in_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  @override
  void initState() {
    user = _auth.currentUser!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (() {}), icon: const Icon(Icons.menu)),
        title: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: (() => logOut().then((value) => {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          SignInScreen.routeName,
                          (Route<dynamic> route) => false),
                    })),
                icon: const Icon(Icons.account_circle))),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10)),
        child: Column(
          children: [
            WelcomeMessage(user: user),
            Row(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
            AddTaskScreen.routeName, ModalRoute.withName(HomePage.routeName)),
        tooltip: 'It helps to add a new Task',
        child: const Icon(Icons.add),
      ), //
    );
  }
}

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hello ${user.displayName} !",
                style: Theme.of(context).textTheme.headlineMedium,
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Have a nice day.",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }
}
