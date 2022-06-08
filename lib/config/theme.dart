import 'package:flutter/material.dart';
import 'package:task_lock/config/constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kBackgroundColor,
    fontFamily: "Roboto",
    primarySwatch: Colors.indigo,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: textTheme(),
    iconTheme: const IconThemeData(color: kPrimaryColor),
    appBarTheme: apparTheme(),
  );
}

TextTheme textTheme() {
  return const TextTheme(
      displaySmall: TextStyle(color: kBackgroundColor, fontFamily: "Poppins"),
      headlineLarge: TextStyle(color: kTextColor, fontFamily: "Poppins"),
      headlineMedium: TextStyle(color: kTextColor, fontFamily: "Poppins"),
      titleLarge: TextStyle(color: kPrimaryLightColor, fontFamily: "Poppins"),
      titleMedium: TextStyle(color: kPrimaryLightColor));
}

AppBarTheme apparTheme() {
  return const AppBarTheme(
    color: kBackgroundColor,
    centerTitle: true,
    elevation: 0,
    iconTheme: IconThemeData(color: kPrimaryColor, size: 32),
    titleTextStyle:
        TextStyle(color: kTextColor, fontSize: 20, fontFamily: "Merriweather"),
  );
}
