import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/counter.dart';
import '../utils/tile.dart';
import '../utils/custom_toggle_button.dart';
import '../utils/style.dart';

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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const Center(
            child: Text(
              "Auto",
              style: Style.title,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: CustomToggleButton(
              text: "Taxi Used",
              value: _taxi,
              onPressed: () => setState(() => _taxi = !_taxi),
            ),
          ),
          const SizedBox(height: 20),
          Row(children: [
            Flexible(
              child: Tile(
                isRadio: false,
                child: Column(
                  children: [
                    const Text(
                      "Low Goal",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Counter(
                      label: "Scored",
                      value: _lowHits,
                      onIncrease: (value) => setState(() => _lowHits++),
                      onDecrease: (value) => setState(() {
                        if (_lowHits > 0) _lowHits--;
                      }),
                    ),
                    Counter(
                      label: "Missed",
                      value: _lowMisses,
                      onIncrease: (value) => setState(() => _lowMisses++),
                      onDecrease: (value) => setState(() {
                        if (_lowMisses > 0) _lowMisses--;
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Tile(
                isRadio: false,
                child: Column(
                  children: [
                    const Text(
                      "High Goal",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Counter(
                      label: "Scored",
                      value: _highHits,
                      onIncrease: (value) => setState(() => _highHits++),
                      onDecrease: (value) => setState(() {
                        if (_highHits > 0) _highHits--;
                      }),
                    ),
                    Counter(
                      label: "Missed",
                      value: _highMisses,
                      onIncrease: (value) => setState(() => _highMisses++),
                      onDecrease: (value) => setState(() {
                        if (_highMisses > 0) _highMisses--;
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
