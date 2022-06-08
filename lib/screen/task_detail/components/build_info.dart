import 'package:flutter/material.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';

Widget buildInfo(String title, String value) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              fontSize: getProportionateScreenWidth(24),
              color: kPrimaryColor),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.05),
        Text(
          value,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: "Poppins",
              fontSize: getProportionateScreenWidth(22),
              color: kBackgroundColor),
        ),
      ],
    );
