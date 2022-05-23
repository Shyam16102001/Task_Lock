import 'package:flutter/material.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        const Icon(
          Icons.error_outline,
          color: Color(0xFFD50000),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Text(
          error,
          style: const TextStyle(color: kPrimaryLightColor),
        ),
      ],
    );
  }
}
