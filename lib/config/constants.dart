import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF2E3A59);
const kPrimaryLightColor = Color(0xFF958E95);
const kSecondaryColor = Color(0xFF7832FF);
const kTextColor = Color(0xFF2E3A59);
const kBackgroundColor = Color(0xFFE5E5E5);
const kAnimationDuration = Duration(milliseconds: 200);

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
