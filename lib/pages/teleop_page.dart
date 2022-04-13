import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/counter.dart';
import '../utils/tile.dart';
import '../utils/custom_toggle_button.dart';
import '../utils/style.dart';

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
              "Teleop",
              style: Style.title,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: CustomToggleButton(
              text: "Defensive Play",
              value: _defensive,
              onPressed: () => setState(() => _defensive = !_defensive),
            ),
          ),
          const SizedBox(height: 20),
          Tile(
            isRadio: false,
            child: Row(children: [
              Flexible(
                child: Counter(
                  label: "Foul",
                  value: _fouls,
                  onIncrease: (value) => setState(() => _fouls++),
                  onDecrease: (value) => setState(() {
                    if (_fouls > 0) _fouls--;
                  }),
                ),
              ),
              Flexible(
                child: Counter(
                  label: "Tech Foul",
                  value: _techFouls,
                  onIncrease: (value) => setState(() => _techFouls++),
                  onDecrease: (value) => setState(() {
                    if (_techFouls > 0) _techFouls--;
                  }),
                ),
              ),
            ]),
          ),
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
