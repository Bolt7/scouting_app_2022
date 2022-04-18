import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/button.dart';
import '../utils/tile.dart';

enum Rung { none, low, mid, high, traversal }

class EndgamePage extends StatefulWidget {
  const EndgamePage({Key? key}) : super(key: key);

  @override
  State<EndgamePage> createState() => _EndgamePageState();
}

class _EndgamePageState extends State<EndgamePage> {
  Rung _rung = Rung.none;

  // Data Management
  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() => _rung = Rung.values[preferences.getInt("rung") ?? 0]);
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt("rung", _rung.index);

    preferences.setBool("Low Rung Success", false);
    preferences.setBool("Mid Rung Success", false);
    preferences.setBool("High Rung Success", false);
    preferences.setBool("Traversal Rung Success", false);

    switch (_rung) {
      case Rung.none:
        break;
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
        SizedBox(
          height: MediaQuery.of(context).size.height - 150,
          child: Tile(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: CustomButton(
                      text: "None",
                      value: Rung.none,
                      groupValue: _rung,
                      onPressed: () => setState(() => _rung = Rung.none),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    fit: FlexFit.tight,
                    child: CustomButton(
                      text: "Low",
                      value: Rung.low,
                      groupValue: _rung,
                      onPressed: () => setState(() => _rung = Rung.low),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    fit: FlexFit.tight,
                    child: CustomButton(
                      text: "Mid",
                      value: Rung.mid,
                      groupValue: _rung,
                      onPressed: () => setState(() => _rung = Rung.mid),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    fit: FlexFit.tight,
                    child: CustomButton(
                      text: "High",
                      value: Rung.high,
                      groupValue: _rung,
                      onPressed: () => setState(() => _rung = Rung.high),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    fit: FlexFit.tight,
                    child: CustomButton(
                      text: "Traversal",
                      value: Rung.traversal,
                      groupValue: _rung,
                      onPressed: () => setState(() => _rung = Rung.traversal),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
