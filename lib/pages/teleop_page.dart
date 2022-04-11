import 'package:flutter/material.dart';
import 'package:scouting_test/utils/custom_toggle_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/counter_tile.dart';

class TeleopPage extends StatefulWidget {
  const TeleopPage({Key? key}) : super(key: key);

  @override
  State<TeleopPage> createState() => _TeleopPageState();
}

class _TeleopPageState extends State<TeleopPage> {
  static const int _numberMax = 10;
  static const int _numberMin = 0;

  bool _defending = false;
  int _fouls = 0;
  int _techFouls = 0;
  int _lowHits = 0;
  int _highHits = 0;
  int _lowMisses = 0;
  int _highMisses = 0;

  void _updateData(int value, String label, bool direction) {
    final bool allowed;
    final int newValue;

    if (direction) {
      allowed = value < _numberMax;
      newValue = value + 1;
    } else {
      allowed = value > _numberMin;
      newValue = value - 1;
    }

    if (!allowed) return;

    setState(() {
      switch (label) {
        case "Foul":
          _fouls = newValue;
          break;
        case "Tech Foul":
          _techFouls = newValue;
          break;
        case "Low Hit":
          _lowHits = newValue;
          break;
        case "High Hit":
          _highHits = newValue;
          break;
        case "Low Miss":
          _lowMisses = newValue;
          break;
        case "High Miss":
          _highMisses = newValue;
          break;
      }
    });
  }

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _defending = preferences.getBool("defending") ?? false;
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
    await preferences.setBool("defending", _defending);
    await preferences.setInt("Foul", _fouls);
    await preferences.setInt("Tech Foul", _techFouls);
    await preferences.setInt("Teleop Low Goal Scored", _lowHits);
    await preferences.setInt("Teleop High Goal Scored", _highHits);
    await preferences.setInt("Teleop Low Goal Miss", _lowMisses);
    await preferences.setInt("Teleop High Goal Miss", _highMisses);
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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Teleop",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        CustomToggleButton(
          text: "Robot Defending",
          value: _defending,
          onPressed: () => setState(() {
            _defending = !_defending;
          }),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: CounterTile(
                  label: "Foul",
                  value: _fouls,
                  onIncrease: (value) {
                    _updateData(value, "Foul", true);
                  },
                  onDecrease: (value) {
                    _updateData(value, "Foul", false);
                  },
                ),
              ),
              Expanded(
                child: CounterTile(
                  label: "Tech Foul",
                  value: _techFouls,
                  onIncrease: (value) {
                    _updateData(value, "Tech Foul", true);
                  },
                  onDecrease: (value) {
                    _updateData(value, "Tech Foul", false);
                  },
                ),
              ),
            ],
          ),
        ),
        Row(children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "Low Goal",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CounterTile(
                    label: "Scored",
                    value: _lowHits,
                    onIncrease: (value) {
                      _updateData(value, "Low Hit", true);
                    },
                    onDecrease: (value) {
                      _updateData(value, "Low Hit", false);
                    },
                  ),
                  CounterTile(
                    label: "Missed",
                    value: _lowMisses,
                    onIncrease: (value) {
                      _updateData(value, "Low Miss", true);
                    },
                    onDecrease: (value) {
                      _updateData(value, "Low Miss", false);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "High Goal",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CounterTile(
                    label: "Scored",
                    value: _highHits,
                    onIncrease: (value) {
                      _updateData(value, "High Hit", true);
                    },
                    onDecrease: (value) {
                      _updateData(value, "High Hit", false);
                    },
                  ),
                  CounterTile(
                    label: "Missed",
                    value: _highMisses,
                    onIncrease: (value) {
                      _updateData(value, "High Miss", true);
                    },
                    onDecrease: (value) {
                      _updateData(value, "High Miss", false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
