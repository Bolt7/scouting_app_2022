import 'dart:async';

import 'package:flutter/material.dart';

import '../pages/auto_page.dart';
import '../pages/endgame_page.dart';
import '../pages/home_page.dart';
import '../pages/teleop_page.dart';
import '../utils/appbar.dart';
import '../utils/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scouting App 2022",
      theme: ThemeData(
        primarySwatch: Palette.primaryColor,
      ),
      home: const MyHomePage(title: "Scouting App"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showTimer = false;
  int _time = 0;
  int _selectedPage = 0;

  void _autoButtonFunction() async {
    if (_showTimer) return;

    // start of auto
    setState(() {
      _selectedPage = 1;
      _showTimer = true;
      _time = 15;
    });

    for (int i = 150; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        if (i > 135) {
          _time = i - 135;
        } else if (i == 135) {
          _time = 0;
          _selectedPage = 2;
        } else {
          _time = i;
        }
      });
    }

    setState(() {
      _selectedPage = 3;
      _showTimer = false;
    });
  }

  // Page Navigation
  late final List<Widget> _pages = <Widget>[
    HomePage(autoButtonFunction: _autoButtonFunction),
    const AutoPage(),
    const TeleopPage(),
    const EndgamePage(),
  ];
  void _onNavigationItemTapped(int index) {
    setState(() => _selectedPage = index);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Palette.primaryColor,
        unselectedItemColor: Palette.inactiveButton,
        fixedColor: Palette.primaryContrast,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPage,
        onTap: _onNavigationItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Main",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.computer),
            label: "Auto",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: "Teleop",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: "Endgame",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: _pages[_selectedPage],
      ),
      floatingActionButton: _showTimer
          ? Align(
              alignment: const Alignment(1, -0.7),
              child: FloatingActionButton(
                onPressed: null,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "$_time",
                      style: const TextStyle(
                        fontSize: 100, // will be shrunk to size
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
