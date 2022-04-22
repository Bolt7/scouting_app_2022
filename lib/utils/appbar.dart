import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/palette.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  //copied from https://stackoverflow.com/a/52678686/18758848
  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final _teamNumberController = TextEditingController();

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(
        () => _teamNumberController.text = preferences.getString("Team") ?? "");
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("Team", _teamNumberController.text);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    _saveData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Baseline(
            baseline: 25,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "Team Number:",
              style: TextStyle(
                color: Palette.primaryContrast,
                fontWeight: FontWeight.normal,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Baseline(
            baseline: 60,
            baselineType: TextBaseline.alphabetic,
            child: SizedBox(
              width: 70,
              child: TextField(
                maxLength: 4,
                keyboardType: TextInputType.number,
                controller: _teamNumberController,
                onChanged: (_) async {
                  final preferences = await SharedPreferences.getInstance();
                  preferences.setString("Team", _teamNumberController.text);
                },
                decoration: const InputDecoration(
                  // contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: "____",
                  hintStyle: TextStyle(
                    fontSize: 38,
                    color: Palette.inactiveButton,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 30,
                  color: Palette.primaryContrast,
                ),
                cursorColor: Palette.primaryContrast,
              ),
            ),
          ),
          Baseline(
            baseline: 30,
            baselineType: TextBaseline.ideographic,
            child: GestureDetector(
              onTap: () async {
                setState(() => _teamNumberController.text = "");
                final preferences = await SharedPreferences.getInstance();
                preferences.setString("Team", "");
              },
              child: const Icon(
                Icons.clear_rounded,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
