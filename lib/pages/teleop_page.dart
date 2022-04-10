// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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

  int _fowls = 0;
  int _techFowls = 0;
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
        case "Fowl":
          _fowls = newValue;
          break;
        case "Tech Fowl":
          _techFowls = newValue;
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
      _fowls = preferences.getInt("fowls") ?? 0;
      _techFowls = preferences.getInt("techFowls") ?? 0;
      _lowHits = preferences.getInt("lowHits") ?? 0;
      _highHits = preferences.getInt("highHits") ?? 0;
      _lowMisses = preferences.getInt("lowMisses") ?? 0;
      _highMisses = preferences.getInt("highMisses") ?? 0;
    });
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt("fowls", _fowls);
    await preferences.setInt("techFowls", _techFowls);
    await preferences.setInt("lowHits", _lowHits);
    await preferences.setInt("highHits", _highHits);
    await preferences.setInt("lowMisses", _lowMisses);
    await preferences.setInt("highMisses", _highMisses);
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Teleop Placeholder",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(children: [
          CounterTile(
            label: "Fowl",
            value: _fowls,
            onIncrease: (value) {
              _updateData(value, "Fowl", true);
            },
            onDecrease: (value) {
              _updateData(value, "Fowl", false);
            },
          ),
          CounterTile(
            label: "Tech Fowl",
            value: _techFowls,
            onIncrease: (value) {
              _updateData(value, "Tech Fowl", true);
            },
            onDecrease: (value) {
              _updateData(value, "Tech Fowl", false);
            },
          ),
        ]),
        Row(children: [
          CounterTile(
            label: "Low Hit",
            value: _lowHits,
            onIncrease: (value) {
              _updateData(value, "Low Hit", true);
            },
            onDecrease: (value) {
              _updateData(value, "Low Hit", false);
            },
          ),
          CounterTile(
            label: "High Hit",
            value: _highHits,
            onIncrease: (value) {
              _updateData(value, "High Hit", true);
            },
            onDecrease: (value) {
              _updateData(value, "High Hit", false);
            },
          ),
        ]),
        Row(children: [
          CounterTile(
            label: "Low Miss",
            value: _lowMisses,
            onIncrease: (value) {
              _updateData(value, "Low Miss", true);
            },
            onDecrease: (value) {
              _updateData(value, "Low Miss", false);
            },
          ),
          CounterTile(
            label: "High Miss",
            value: _highMisses,
            onIncrease: (value) {
              _updateData(value, "High Miss", true);
            },
            onDecrease: (value) {
              _updateData(value, "High Miss", false);
            },
          ),
        ]),
      ],
    );
  }
}
