// ignore_for_file: avoid_returning_null_for_void

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_lock/components/continue_button.dart';
import 'package:task_lock/components/form_error.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/data_service/auth/create_account.dart';
import 'package:task_lock/screen/home_page/home_page.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  late String password;
  late String confirmPassword;
  bool autherror = false;
  List<String> errors = [];
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: Colors.black54),
    gapPadding: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          nameFormFiled(),
          SizedBox(height: getProportionateScreenHeight(25)),
          emailFormFiled(),
          SizedBox(height: getProportionateScreenHeight(25)),
          passwordFormField(),
          SizedBox(height: getProportionateScreenHeight(25)),
          confirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(25)),
          ContinueButton(
              text: "Sign Up",
              press: () {
                removeError(error: kSignUpError);
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  createAccount(email, confirmPassword).then((user) => {
                        if (user != null)
                          {
                            user.updateDisplayName(name),
                            user.reload(),
                            FirebaseFirestore.instance
                                .collection("Tasks")
                                .doc(user.email)
                                .set({"Coins": 100}),
                            Navigator.popAndPushNamed(
                                context, HomePage.routeName),
                          }
                        else
                          {
                            errors = [],
                            addError(error: kSignUpError),
                          }
                      });
                }
              })
        ],
      ),
    );
  }

  TextFormField confirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue!,
      style: const TextStyle(color: kTextColor, fontSize: 15),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(error: kMatchPassError);
        }
        confirmPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
        hintStyle: const TextStyle(color: kPrimaryLightColor, fontSize: 18),
        labelStyle: const TextStyle(color: kTextColor, fontSize: 24),
        hintText: "Confirm Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(
          Icons.lock,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  TextFormField passwordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      style: const TextStyle(color: kTextColor, fontSize: 18),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
        hintStyle: const TextStyle(color: kPrimaryLightColor, fontSize: 18),
        labelStyle: const TextStyle(color: kTextColor, fontSize: 24),
        hintText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(
          Icons.lock,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  TextFormField emailFormFiled() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      style: const TextStyle(color: kTextColor, fontSize: 18),
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
          return "";
        } else {
          if (!emailValidatorRegExp.hasMatch(value) &&
              !errors.contains(kInvalidEmailError)) {
            setState(() {
              errors.add(kInvalidEmailError);
            });
            return "";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
        hintStyle: const TextStyle(color: kPrimaryLightColor, fontSize: 18),
        labelStyle: const TextStyle(color: kTextColor, fontSize: 24),
        hintText: "Email ID",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(
          Icons.mail,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  TextFormField nameFormFiled() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue!,
      style: const TextStyle(color: kTextColor, fontSize: 18),
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kNameNullError)) {
          setState(() {
            errors.remove(kNameNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && errors.contains(kNameNullError)) {
          setState(() {
            errors.add(kNameNullError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
        hintStyle: const TextStyle(color: kPrimaryLightColor, fontSize: 18),
        labelStyle: const TextStyle(color: kTextColor, fontSize: 24),
        hintText: "Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(
          Icons.person,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
