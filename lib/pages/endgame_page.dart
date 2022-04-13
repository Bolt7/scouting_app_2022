import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/tile.dart';
import '../utils/custom_radio_button.dart';
import '../utils/style.dart';

enum Try { none, attempt, success }
enum Rung { low, mid, high, traversal }
enum Speed { slow, medium, fast }

class EndgamePage extends StatefulWidget {
  const EndgamePage({Key? key}) : super(key: key);

  @override
  State<EndgamePage> createState() => _EndgamePageState();
}

class _EndgamePageState extends State<EndgamePage> {
  Try _try = Try.none;
  Rung _rung = Rung.low;
  Speed _speed = Speed.slow;

  void _updateTry(Try? value) => setState(() => _try = value!);
  void _updateRung(Rung? value) => setState(() => _rung = value!);
  void _updateSpeed(Speed? value) => setState(() => _speed = value!);

  // Data Management
  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _try = Try.values[preferences.getInt("try") ?? 0];
      _rung = Rung.values[preferences.getInt("rung") ?? 0];
      _speed = Speed.values[preferences.getInt("speed") ?? 0];
    });
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt("try", _try.index);
    preferences.setInt("rung", _rung.index);
    preferences.setInt("speed", _speed.index);

    preferences.setBool("Low Rung Success", false);
    preferences.setBool("Mid Rung Success", false);
    preferences.setBool("High Rung Success", false);
    preferences.setBool("Traversal Rung Success", false);

    if (_try == Try.success) {
      switch (_rung) {
        case Rung.low:
          preferences.setBool("Low Rung Success", true);
          break;
        case Rung.mid:
          preferences.setBool("Mid Rung Success", true);
          break;
        case Rung.high:
          preferences.setBool("High Rung Success", true);
          break;
        case Rung.traversal:
          preferences.setBool("Traversal Rung Success", true);
      }
    }
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
        scrollDirection: Axis.vertical,
        children: [
          const Center(
            child: Text(
              "Endgame",
              style: Style.title,
            ),
          ),
          const SizedBox(height: 10),

          // Try Radio Buttons
          Tile(
            isRadio: true,
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
          Tile(
            isRadio: true,
            child: Column(
              children: [
                Row(children: [
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
                ]),
                const SizedBox(height: 10),
                Row(children: [
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
                ])
              ],
            ),
          ),

          // Speed Radio Buttons
          Tile(
            isRadio: true,
            child: Row(children: [
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
            ]),
          ),
        ],
      ),
    );
  }
}
