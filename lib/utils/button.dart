// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/palette.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Enum? groupValue;
  final dynamic value; //bool or enum of the same type as groupValue

  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.value,
    this.groupValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
        HapticFeedback.lightImpact(); //touch feedback
        Feedback.forTap(context); //sound feedback
      },
      child: Container(
        decoration: BoxDecoration(
          color: Palette.primaryContrast,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: groupValue != null //depends on button type (?radio:toggle)
                ? value == groupValue
                    ? Palette.primaryColor
                    : Palette.inactiveButton
                : value
                    ? Palette.primaryColor
                    : Palette.inactiveButton,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 50,
                color: groupValue != null
                    ? value == groupValue
                        ? Palette.primaryColor
                        : Palette.inactiveButton
                    : value
                        ? Palette.primaryColor
                        : Palette.inactiveButton,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
