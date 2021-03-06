import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/button.dart';

class HomePage extends StatefulWidget {
  final Function qrButtonFunction;
  final Function timer;

  const HomePage({
    required this.qrButtonFunction,
    required this.timer,
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _commentController = TextEditingController();
  bool _disabled = false;
  bool _incapacitated = false;
  bool _late = false;

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _disabled = preferences.getBool("disabled") ?? false;
      _incapacitated = preferences.getBool("incap") ?? false;
      _late = preferences.getBool("late") ?? false;
      _commentController.text = preferences.getString("Comments") ?? "";
    });
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setBool("disabled", _disabled);
    preferences.setBool("incap", _incapacitated);
    preferences.setBool("late", _late);
    preferences.setString("Comments", _commentController.text);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    _saveData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        CustomButton(
          text: "Disabled",
          value: _disabled,
          onPressed: () => setState(() => _disabled = !_disabled),
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: "Incapacitated",
          value: _incapacitated,
          onPressed: () => setState(() => _incapacitated = !_incapacitated),
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: "Started Late",
          value: _late,
          onPressed: () => setState(() => _late = !_late),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _commentController,
          decoration: const InputDecoration(labelText: "Comments"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith((state) {
              return const EdgeInsets.symmetric(vertical: 10);
            }),
          ),
          onPressed: () => widget.qrButtonFunction(),
          child: const Text(
            "QR Code",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith((state) {
              return const EdgeInsets.symmetric(vertical: 10);
            }),
          ),
          onPressed: () {
            widget.timer();
          },
          child: const Text(
            "Start/Stop Auto",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        )
      ],
    );
  }
}
