// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final String text;
  final Enum groupValue;
  final Enum value;
  final Function onChanged;

  const CustomRadioButton({
    required this.text,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return Colors.white;
            }),
            padding: MaterialStateProperty.resolveWith((states) {
              return const EdgeInsets.all(10);
            }),
            side: MaterialStateProperty.resolveWith((states) {
              return BorderSide(
                width: 2,
                color: (value == groupValue) ? Colors.indigo : Colors.grey,
              );
            }),
          ),
          onPressed: () => onChanged(value),
          child: Text(
            text,
            style: TextStyle(
              color: (value == groupValue) ? Colors.indigo : Colors.grey,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
