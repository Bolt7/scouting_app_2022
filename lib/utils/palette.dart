// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

/*
Old Colors
Colors.indigo
Colors.blue[200]
Colors.grey
Colors.white

New Colors
Color.fromARGB(255, 3, 34, 56)
*/
class Palette {
  static var primaryColor = MaterialColor(0xff172238, {
    50: Colors.white,
    100: Colors.white,
    200: Colors.white,
    300: Colors.white,
    400: Colors.white,
    500: Colors.white,
    600: Colors.white,
    700: Colors.white,
    800: Colors.white,
    900: Colors.white,
  });

  // MaterialColor(
  //   0xff172238,
  //   <int, Color>{
  //     50: Color(0xffce5641), //10%
  //     100: Color(0xffb74c3a), //20%
  //     200: Color(0xffa04332), //30%
  //     300: Color(0xff89392b), //40%
  //     400: Color(0xff733024), //50%
  //     500: Color(0xff5c261d), //60%
  //     600: Color(0xff451c16), //70%
  //     700: Color(0xff2e130e), //80%
  //     800: Color(0xff170907), //90%
  //     900: Color(0xff000000), //100%
  //   },
  // );
  static const primaryContrast = Colors.white;

  static const inactiveButton = Colors.grey;
  static const tileColor = Color.fromARGB(255, 190, 190, 255);
}
