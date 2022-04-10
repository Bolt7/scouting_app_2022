// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _teamNameController = TextEditingController();

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    final String? teamName = preferences.getString("teamName");
    setState(() {
      _teamNameController.text = teamName!;
    });
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("teamName", _teamNameController.text);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            "Home Placeholder",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 10),
                color: Colors.red,
                child: Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: null,
                    ),
                    Text(
                      "Red Label",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "D. Joe",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text("Insert Team Details"),
          TextField(
            controller: _teamNameController,
            decoration: InputDecoration(labelText: "Team Number"),
          ),
          TextButton(
            onPressed: _saveData,
            child: Text("Save Data"),
          ),
        ],
      ),
    );
  }
}
