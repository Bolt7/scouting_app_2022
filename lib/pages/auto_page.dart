import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/counter_tile.dart';

class AutoPage extends StatefulWidget {
  const AutoPage({Key? key}) : super(key: key);

  @override
  State<AutoPage> createState() => _AutoPageState();
}

class _AutoPageState extends State<AutoPage> {
  static const int _numberMax = 10;
  static const int _numberMin = 0;
  int _lowHits = 0;
  int _highHits = 0;
  int _lowMisses = 0;
  int _highMisses = 0;
  bool _taxi = false;

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
        case "Auto Low Hit":
          _lowHits = newValue;
          break;
        case "Auto High Hit":
          _highHits = newValue;
          break;
        case "Auto Low Miss":
          _lowMisses = newValue;
          break;
        case "Auto High Miss":
          _highMisses = newValue;
          break;
      }
    });
  }

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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Auto",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 125),
          child: CheckboxListTile(
            value: _taxi,
            title: const Text("Taxi"),
            onChanged: (value) {
              setState(() {
                _taxi = !_taxi;
              });
            },
          ),
        ),
        Row(children: [
          CounterTile(
            label: "Auto Low Hit",
            value: _lowHits,
            onIncrease: (value) {
              _updateData(value, "Auto Low Hit", true);
            },
            onDecrease: (value) {
              _updateData(value, "Auto Low Hit", false);
            },
          ),
          CounterTile(
            label: "Auto High Hit",
            value: _highHits,
            onIncrease: (value) async {
              _updateData(value, "Auto High Hit", true);
            },
            onDecrease: (value) async {
              _updateData(value, "Auto High Hit", false);
            },
          ),
        ]),
        Row(children: [
          CounterTile(
            label: "Auto Low Miss",
            value: _lowMisses,
            onIncrease: (value) {
              _updateData(value, "Auto Low Miss", true);
            },
            onDecrease: (value) {
              _updateData(value, "Auto Low Miss", false);
            },
          ),
          CounterTile(
            label: "Auto High Miss",
            value: _highMisses,
            onIncrease: (value) {
              _updateData(value, "Auto High Miss", true);
            },
            onDecrease: (value) {
              _updateData(value, "Auto High Miss", false);
            },
          ),
        ]),
      ],
    );
  }
}
