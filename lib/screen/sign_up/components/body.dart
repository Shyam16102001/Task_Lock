import 'package:flutter/material.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/screen/sign_in/sign_in_screen.dart';
import 'package:task_lock/screen/sign_up/components/signup_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.headlineLarge,
                  )),
              SizedBox(height: getProportionateScreenHeight(10)),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please fill the form.",
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
              SizedBox(height: getProportionateScreenHeight(40)),
              const SignUpForm(),
              SizedBox(height: getProportionateScreenHeight(60)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context, SignInScreen.routeName, (route) => false),
                    child: Text(
                      " Sign In",
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                          const TextStyle(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
            ],
          ),
        ),
      ),
    ));
  }
}
