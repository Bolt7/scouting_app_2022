import "package:csv/csv.dart";
import "package:flutter/material.dart";
import "package:qr_flutter/qr_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  String data = "";

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    List<List> csvList = [
      [
        "Team",
        "Taxi",
        "Auto Low Goal Scored",
        "Auto High Goal Scored",
        "Auto Low Goal Miss",
        "Auto High Goal Miss",
        "Teleop Low Goal Scored",
        "Teleop High Goal Scored",
        "Teleop Low Goal Miss",
        "Teleop High Goal Miss",
        "Foul",
        "Tech Foul",
        "Low Rung Success",
        "Mid Rung Success",
        "High Rung Success",
        "Traversal Rung Success",
        "Ranking Points",
        "Comments"
      ],
      ["", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ""]
    ];

    for (var key in csvList[0]) {
      if (preferences.get(key).toString() != "null") {
        final Object? value;
        if (preferences.get(key).runtimeType == bool) {
          value = preferences.get(key) as bool ? 1 : 0;
        } else {
          value = preferences.get(key);
        }
        csvList[1][csvList[0].indexOf(key)] = value;
      }
      // print("$key: ${csvList[1][csvList[0].indexOf(key)]}");
    }
    setState(() {
      data = const ListToCsvConverter().convert(csvList);
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          QrImage(data: data),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Text(
              data,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            child: const Text("Reset Data"),
            onPressed: () {
              // ignore: invalid_use_of_visible_for_testing_member
              SharedPreferences.setMockInitialValues({});
            },
          )
        ],
      ),
    );
  }
}
