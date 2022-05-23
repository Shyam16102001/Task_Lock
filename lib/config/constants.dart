import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFE6E1E4);
const kPrimaryLightColor = Color(0xFF958E95);
const kSecondaryColor = Color(0xFF35B5AD);
const kTextColor = Color(0xFFE6E1E4);
const kBackgroundColor = Color(0xFF2C2B3F);
const kAnimationDuration = Duration(milliseconds: 200);

// final headingStyle = TextStyle(
//   color: kPrimaryColor,
//   // fontSize: getProportionateScreenWidth(38),
//   fontWeight: FontWeight.bold,
//   fontFamily: "Lato",
// );

const String appName = "Peca";
const String quote = "A Digital Pet Care System";
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kNameNullError = "Please enter your name";
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter Valid Email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kSignUpError = "Account Already Exists.Please Sign In";
const String kSignInError = "Invalid Email or Password";
const String kEmailSent = "Email has been sent";
const String kEmailNotSent = "Something went wrong.Please try again";
