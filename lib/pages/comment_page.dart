import 'package:flutter/material.dart';
import 'package:scouting_app_2022/utils/custom_toggle_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _commentController = TextEditingController();
  final _pointController = TextEditingController();
  bool _disabled = false;
  bool _incapacitated = false;
  bool _late = false;
  bool _scoutRequired = false;

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _disabled = preferences.getBool("disabled") ?? false;
      _incapacitated = preferences.getBool("incapacitated") ?? false;
      _late = preferences.getBool("late") ?? false;
      _scoutRequired = preferences.getBool("scoutRequired") ?? false;
      _commentController.text = preferences.getString("Comments") ?? "";
      _pointController.text = preferences.getString("Ranking Points") ?? "";
    });
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setBool("disabled", _disabled);
    preferences.setBool("incapacitated", _incapacitated);
    preferences.setBool("late", _late);
    preferences.setBool("scoutRequired", _scoutRequired);
    preferences.setString("Comments", _commentController.text);
    preferences.setString("Ranking Points", _pointController.text);
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          const Center(
            child: Text(
              "Info",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomToggleButton(
            text: "Robot Disabled",
            value: _disabled,
            onPressed: () => setState(() => _disabled = !_disabled),
          ),
          const SizedBox(height: 10),
          CustomToggleButton(
            text: "Robot Incapacitated",
            value: _incapacitated,
            onPressed: () => setState(() => _incapacitated = !_incapacitated),
          ),
          const SizedBox(height: 10),
          CustomToggleButton(
            text: "Entry Started late",
            value: _late,
            onPressed: () => setState(() => _late = !_late),
          ),
          const SizedBox(height: 10),
          CustomToggleButton(
            text: "Scout Required",
            value: _scoutRequired,
            onPressed: () => setState(() => _scoutRequired = !_scoutRequired),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: _pointController,
                  decoration:
                      const InputDecoration(labelText: "Ranking Points"),
                ),
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(labelText: "Comments"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
