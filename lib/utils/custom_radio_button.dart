// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
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
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) {
              return Colors.white;
            }),
          ),
          onPressed: () => widget.onChanged(widget.value),
          child: Text(
            widget.text,
            style: TextStyle(
              color: (widget.value == widget.groupValue)
                  ? Colors.indigo
                  : Colors.grey,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
