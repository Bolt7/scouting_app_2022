// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:scouting_test/utils/custom_radio_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Try { none, attempt, success }
enum Rung { low, mid, high, traversal }
enum Speed { slow, medium, fast }

class EndgamePage extends StatefulWidget {
  const EndgamePage({Key? key}) : super(key: key);

  @override
  State<EndgamePage> createState() => _EndgamePageState();
}

class _EndgamePageState extends State<EndgamePage> {
  // Data Management
  void _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _try = Try.values[preferences.getInt("try") ?? 0];
      _rung = Rung.values[preferences.getInt("rung") ?? 0];
      _speed = Speed.values[preferences.getInt("speed") ?? 0];
    });
  }

  Try _try = Try.none;
  Rung _rung = Rung.low;
  Speed _speed = Speed.slow;

  void _updateTry(Try? value) async {
    setState(
      () {
        _try = value!;
      },
    );
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt("try", _try.index);
  }

  void _updateRung(Rung? value) async {
    setState(
      () {
        _rung = value!;
      },
    );
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt("rung", _rung.index);
  }

  void _updateSpeed(Speed? value) async {
    setState(
      () {
        _speed = value!;
      },
    );
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt("speed", _speed.index);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Endgame Placeholder",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Try Radio Buttons
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadioButton(
                text: "None",
                value: Try.none,
                groupValue: _try,
                onChanged: _updateTry,
              ),
              CustomRadioButton(
                text: "Attempt",
                value: Try.attempt,
                groupValue: _try,
                onChanged: _updateTry,
              ),
              CustomRadioButton(
                text: "Success",
                value: Try.success,
                groupValue: _try,
                onChanged: _updateTry,
              ),
            ],
          ),
        ),

        // Rung Radio Buttons
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomRadioButton(
                    text: "Low Rung",
                    value: Rung.low,
                    groupValue: _rung,
                    onChanged: _updateRung,
                  ),
                  CustomRadioButton(
                    text: "Mid Rung",
                    value: Rung.mid,
                    groupValue: _rung,
                    onChanged: _updateRung,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomRadioButton(
                    text: "High Rung",
                    value: Rung.high,
                    groupValue: _rung,
                    onChanged: _updateRung,
                  ),
                  CustomRadioButton(
                    text: "Traversal Rung",
                    value: Rung.traversal,
                    groupValue: _rung,
                    onChanged: _updateRung,
                  ),
                ],
              )
            ],
          ),
        ),

        // Speed Radio Buttons
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadioButton(
                text: "Slow",
                value: Speed.slow,
                groupValue: _speed,
                onChanged: _updateSpeed,
              ),
              CustomRadioButton(
                text: "Medium",
                value: Speed.medium,
                groupValue: _speed,
                onChanged: _updateSpeed,
              ),
              CustomRadioButton(
                text: "Fast",
                value: Speed.fast,
                groupValue: _speed,
                onChanged: _updateSpeed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
