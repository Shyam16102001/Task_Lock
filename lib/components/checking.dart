import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/screen/home_page/home_page.dart';
import 'package:task_lock/screen/sign_in/sign_in_screen.dart';

class Checking extends StatefulWidget {
  const Checking({Key? key}) : super(key: key);
  static String routeName = "/checking";

  @override
  CheckingState createState() => CheckingState();
}

class CheckingState extends State<Checking> {
  late Timer timer;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    Future.delayed(const Duration(seconds: 0), () {
      checkLogin();
    });
    super.initState();
  }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: kSecondaryColor,
          size: 75.0,
        ),
      ),
    );
  }

  Future<void> checkLogin() async {
    user = _auth.currentUser;
    // timer.cancel();
    if (_auth.currentUser != null) {
      // UserData();
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    }
  }
}
