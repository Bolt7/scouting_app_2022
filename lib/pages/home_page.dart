import 'package:flutter/material.dart';
import 'package:scouting_test/pages/qr_page.dart';
import 'package:scouting_test/utils/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/custom_radio_button.dart';

enum Station { r1, r2, r3, b1, b2, b3 }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _teamNameController = TextEditingController();
  final _scoutNameController = TextEditingController();
  Station _station = Station.b1;

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _teamNameController.text = preferences.getString("Team") ?? "";
      _scoutNameController.text = preferences.getString("scoutName") ?? "";
      _station = Station.values[preferences.getInt("station") ?? 0];
    });
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("Team", _teamNameController.text);
    await preferences.setString("scoutName", _scoutNameController.text);
    await preferences.setInt("station", _station.index);
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
        children: [
          const Center(
            child: Text(
              "Main",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: _scoutNameController,
                  decoration: const InputDecoration(labelText: "Scout Name"),
                ),
                TextField(
                  controller: _teamNameController,
                  decoration: const InputDecoration(
                    labelText: "Team Number",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Station",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
            decoration: BoxDecoration(
              color: Palette.tileColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(children: [
                  CustomRadioButton(
                      text: "Red 1",
                      groupValue: _station,
                      value: Station.r1,
                      onChanged: (Station value) {
                        setState(() {
                          _station = value;
                        });
                      }),
                  CustomRadioButton(
                      text: "Red 2",
                      groupValue: _station,
                      value: Station.r2,
                      onChanged: (Station value) {
                        setState(() {
                          _station = value;
                        });
                      }),
                  CustomRadioButton(
                      text: "Red 3",
                      groupValue: _station,
                      value: Station.r3,
                      onChanged: (Station value) {
                        setState(() {
                          _station = value;
                        });
                      }),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  CustomRadioButton(
                      text: "Blue 1",
                      groupValue: _station,
                      value: Station.b1,
                      onChanged: (Station value) {
                        setState(() {
                          _station = value;
                        });
                      }),
                  CustomRadioButton(
                      text: "Blue 2",
                      groupValue: _station,
                      value: Station.b2,
                      onChanged: (Station value) {
                        setState(() {
                          _station = value;
                        });
                      }),
                  CustomRadioButton(
                      text: "Blue 3",
                      groupValue: _station,
                      value: Station.b3,
                      onChanged: (Station value) {
                        setState(() {
                          _station = value;
                        });
                      }),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              _saveData();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRPage()),
              );
            },
            child: const Text(
              "Generate QR Code",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
