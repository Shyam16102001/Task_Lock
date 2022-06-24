import 'package:flutter/material.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';

// ignore: must_be_immutable
class ContinueButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  IconData? icon;
  Color? color;
  ContinueButton({
    Key? key,
    required this.text,
    required this.press,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            primary: color ?? kSecondaryColor,
            elevation: 10),
        onPressed: press,
        child: icon == null
            ? Text(text,
                style: TextStyle(
                    fontFamily: "Robato",
                    fontSize: getProportionateScreenWidth(24),
                    color: kBackgroundColor))
            : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Icon(icon),
                Text(text,
                    style: TextStyle(
                      fontFamily: "Robato",
                      fontSize: getProportionateScreenWidth(24),
                      color: kBackgroundColor,
                    ))
              ]),
      ),
    );
  }
}
