import 'package:flutter/material.dart';

import 'package:scouting_app_2022/utils/palette.dart';

class Tile extends StatelessWidget {
  final Widget child;
  final bool isRadio;

  const Tile({
    required this.child,
    required this.isRadio,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: isRadio
          ? const EdgeInsets.symmetric(horizontal: 5, vertical: 9)
          : const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Palette.tileColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
