// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
      _lowHits = preferences.getInt("autoLowHits") ?? 0;
      _highHits = preferences.getInt("autoHighHits") ?? 0;
      _lowMisses = preferences.getInt("autoLowMisses") ?? 0;
      _highMisses = preferences.getInt("autoHighMisses") ?? 0;
    });
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt("autoLowHits", _lowHits);
    await preferences.setInt("autoHighHits", _highHits);
    await preferences.setInt("autoLowMisses", _lowMisses);
    await preferences.setInt("autoHighMisses", _highMisses);
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
            "Auto Placeholder",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
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
