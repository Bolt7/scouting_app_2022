import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/counter.dart';
import '../utils/tile.dart';
import '../utils/button.dart';

class TeleopPage extends StatefulWidget {
  const TeleopPage({Key? key}) : super(key: key);

  @override
  State<TeleopPage> createState() => _TeleopPageState();
}

class _TeleopPageState extends State<TeleopPage> {
  bool _defensive = false;
  int _fouls = 0;
  int _techFouls = 0;
  int _lowHits = 0;
  int _highHits = 0;
  int _lowMisses = 0;
  int _highMisses = 0;

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _defensive = preferences.getBool("Defensive") ?? false;
      _fouls = preferences.getInt("Foul") ?? 0;
      _techFouls = preferences.getInt("Tech Foul") ?? 0;
      _lowHits = preferences.getInt("Teleop Low Goal Scored") ?? 0;
      _highHits = preferences.getInt("Teleop High Goal Scored") ?? 0;
      _lowMisses = preferences.getInt("Teleop Low Goal Miss") ?? 0;
      _highMisses = preferences.getInt("Teleop High Goal Miss") ?? 0;
    });
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool("Defensive", _defensive);
    await preferences.setInt("Foul", _fouls);
    await preferences.setInt("Tech Foul", _techFouls);
    await preferences.setInt("Teleop Low Goal Scored", _lowHits);
    await preferences.setInt("Teleop High Goal Scored", _highHits);
    await preferences.setInt("Teleop Low Goal Miss", _lowMisses);
    await preferences.setInt("Teleop High Goal Miss", _highMisses);
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
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        CustomButton(
          text: "Defensive",
          value: _defensive,
          onPressed: () => setState(() => _defensive = !_defensive),
        ),
        const SizedBox(height: 10),
        Tile(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Counter(
                      label: "Fouls:",
                      value: _fouls,
                      onIncrease: () => setState(() => _fouls++),
                      onDecrease: () => setState(() {
                        if (_fouls > 0) _fouls--;
                      }),
                    ),
                  ),
                  const VerticalDivider(
                    width: 0,
                    thickness: 2,
                    indent: 5,
                    endIndent: 10,
                  ),
                  Expanded(
                    child: Counter(
                      label: "Tech Fouls:",
                      value: _techFouls,
                      onIncrease: () => setState(() => _techFouls++),
                      onDecrease: () => setState(() {
                        if (_techFouls > 0) _techFouls--;
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Low",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Tile(
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Counter(
                          label: "Scored:",
                          value: _lowHits,
                          onIncrease: () => setState(() => _lowHits++),
                          onDecrease: () => setState(() {
                            if (_lowHits > 0) _lowHits--;
                          }),
                        ),
                        const Divider(
                          thickness: 2,
                          indent: 10,
                          endIndent: 10,
                          height: 0,
                        ),
                        const SizedBox(height: 5),
                        Counter(
                          label: "Missed:",
                          value: _lowMisses,
                          onIncrease: () => setState(() => _lowMisses++),
                          onDecrease: () => setState(() {
                            if (_lowMisses > 0) _lowMisses--;
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "High",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Tile(
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Counter(
                          label: "Scored:",
                          value: _highHits,
                          onIncrease: () => setState(() => _highHits++),
                          onDecrease: () => setState(() {
                            if (_highHits > 0) _highHits--;
                          }),
                        ),
                        const Divider(
                          thickness: 2,
                          indent: 10,
                          endIndent: 10,
                          height: 0,
                        ),
                        const SizedBox(height: 5),
                        Counter(
                          label: "Missed:",
                          value: _highMisses,
                          onIncrease: () => setState(() => _highMisses++),
                          onDecrease: () => setState(() {
                            if (_highMisses > 0) _highMisses--;
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
