import 'package:flutter/material.dart';
import 'package:task_lock/config/constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kBackgroundColor,
    fontFamily: "Roboto",
    primarySwatch: Colors.grey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    iconTheme: const IconThemeData(color: kPrimaryColor),
    appBarTheme: apparTheme(),
  );
}

TextTheme textTheme() {
  return const TextTheme(
      headlineLarge: TextStyle(color: kTextColor, fontFamily: "Lato"),
      headlineMedium: TextStyle(color: kTextColor, fontFamily: "Lato"),
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

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: Colors.white54),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    hintStyle: const TextStyle(color: kPrimaryLightColor, fontSize: 18),
    labelStyle: const TextStyle(color: kTextColor, fontSize: 24),
  );
}
