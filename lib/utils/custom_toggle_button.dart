import 'package:flutter/material.dart';

import '../utils/palette.dart';

class CustomToggleButton extends StatelessWidget {
  final String text;
  final bool value;
  final VoidCallback onPressed;

  const CustomToggleButton({
    required this.text,
    required this.value,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return Colors.white;
        }),
        padding: MaterialStateProperty.resolveWith((states) {
          return const EdgeInsets.all(15);
        }),
        side: MaterialStateProperty.resolveWith((states) {
          return BorderSide(
            width: 2,
            color: value ? Palette.primaryColor : Palette.inactiveButton,
          );
        }),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: value ? Palette.primaryColor : Palette.inactiveButton,
        ),
      ),
    );
  }
}
