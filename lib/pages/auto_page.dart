import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/counter.dart';
import '../utils/tile.dart';
import '../utils/button.dart';

class AutoPage extends StatefulWidget {
  const AutoPage({Key? key}) : super(key: key);

  @override
  State<AutoPage> createState() => _AutoPageState();
}

class _AutoPageState extends State<AutoPage> {
  int _lowHits = 0;
  int _highHits = 0;
  int _lowMisses = 0;
  int _highMisses = 0;
  bool _taxi = false;

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _taxi = preferences.getBool("Taxi") ?? false;
      _lowHits = preferences.getInt("Auto Low Goal Scored") ?? 0;
      _highHits = preferences.getInt("Auto High Goal Scored") ?? 0;
      _lowMisses = preferences.getInt("Auto Low Goal Miss") ?? 0;
      _highMisses = preferences.getInt("Auto High Goal Miss") ?? 0;
    });
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool("Taxi", _taxi);
    await preferences.setInt("Auto Low Goal Scored", _lowHits);
    await preferences.setInt("Auto High Goal Scored", _highHits);
    await preferences.setInt("Auto Low Goal Miss", _lowMisses);
    await preferences.setInt("Auto High Goal Miss", _highMisses);
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
          text: "Taxi",
          value: _taxi,
          onPressed: () => setState(() => _taxi = !_taxi),
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
                  const SizedBox(height: 10),
                  Tile(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
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
                          height: 5,
                        ),
                        const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Tile(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
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
                          height: 5,
                        ),
                        const SizedBox(height: 10),
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
