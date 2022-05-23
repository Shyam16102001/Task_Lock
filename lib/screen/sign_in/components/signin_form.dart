import 'package:flutter/material.dart';
import 'package:task_lock/components/continue_button.dart';
import 'package:task_lock/components/form_error.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/data_service/auth/log_in.dart';
import 'package:task_lock/screen/home_page/home_page.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  List<String> errors = [];
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          emailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          passwordFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(13)),
          ContinueButton(
              text: "Log In",
              press: () {
                removeError(error: kSignInError);
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  logIn(email, password).then((user) => {
                        if (user != null)
                          {
                            // UserData(),
                            Navigator.popAndPushNamed(
                                context, HomePage.routeName),
                          }
                        else
                          {
                            errors = [],
                            addError(error: kSignInError),
                          }
                      });
                }
              }),
        ],
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
        return null;
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
      decoration: const InputDecoration(
        hintText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          Icons.lock,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  TextFormField emailFormField() {
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
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
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
      decoration: const InputDecoration(
        hintText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          Icons.mail,
          color: kTextColor,
        ),
      ),
    );
  }
}