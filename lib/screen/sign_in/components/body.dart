import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/screen/sign_in/components/signin_form.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/screen/sign_in/sign_in_screen.dart';
import 'package:task_lock/screen/sign_up/sign_up_screen.dart';

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
              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              SvgPicture.asset(
                "assets/images/login.svg",
                height: getProportionateScreenHeight(250),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.headlineLarge,
                  )),
              SizedBox(height: getProportionateScreenHeight(5)),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please sign in to continue.",
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
              SizedBox(height: getProportionateScreenHeight(20)),
              const SignInForm(),
              SizedBox(height: getProportionateScreenHeight(30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                        SignUpScreen.routeName,
                        ModalRoute.withName(SignInScreen.routeName)),
                    child: Text(
                      " Sign Up",
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
