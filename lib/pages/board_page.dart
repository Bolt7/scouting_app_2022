// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scouting_test/utils/custom_radio_button.dart';

enum Station { r1, r2, r3, b1, b2, b3 }

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  Station _station = Station.b1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRadioButton(
            text: "R1",
            groupValue: _station,
            value: Station.r1,
            onChanged: (Station value) {
              setState(() {
                _station = value;
              });
            })
      ],
    );
  }
}
