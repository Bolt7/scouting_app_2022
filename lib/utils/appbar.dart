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
  final _teamNameController = TextEditingController();

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(
        () => _teamNameController.text = preferences.getString("Team") ?? "");
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("Team", _teamNameController.text);
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
          const Text(
            "Team Number:",
            style: TextStyle(
              color: Palette.primaryContrast,
              fontWeight: FontWeight.normal,
              fontSize: 30,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 13),
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                maxLength: 4,
                keyboardType: TextInputType.number,
                controller: _teamNameController,
                onSubmitted: (_) async {
                  final preferences = await SharedPreferences.getInstance();
                  preferences.setString("Team", _teamNameController.text);
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: "____",
                  hintStyle: TextStyle(
                    fontSize: 38,
                    color: Palette.inactiveButton,
                  ),
                ),
                showCursor: false,
                style: const TextStyle(
                  fontSize: 30,
                  color: Palette.primaryContrast,
                ),
                cursorColor: Palette.primaryContrast,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
