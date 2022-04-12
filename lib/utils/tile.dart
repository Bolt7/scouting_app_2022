import 'package:flutter/material.dart';
import 'package:scouting_app_2022/utils/palette.dart';

class Tile extends StatelessWidget {
  final Widget child;

  const Tile({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Palette.tileColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
